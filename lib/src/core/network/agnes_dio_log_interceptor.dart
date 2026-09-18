import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Formats Dio traffic into compact, searchable request/response blocks.
class AgnesDioLogInterceptor extends Interceptor {
  static const _requestIdKey = '_agnesRequestId';
  static const _stopwatchKey = '_agnesRequestStopwatch';
  static const _maxPayloadLength = 4000;

  int _nextRequestId = 0;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestId = ++_nextRequestId;
    final stopwatch = Stopwatch()..start();
    options.extra[_requestIdKey] = requestId;
    options.extra[_stopwatchKey] = stopwatch;

    _write(
      _formatBlock(
        title: 'REQUEST #${requestId.toString().padLeft(3, '0')}',
        icon: '▶',
        lines: [
          '${options.method.toUpperCase()} ${_redactUri(options.uri)}',
          ..._formatHeaders(options.headers),
        ],
        body: options.data == null ? null : _formatPayload(options.data),
      ),
    );
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final requestOptions = response.requestOptions;
    final elapsed = _stopwatch(requestOptions)?.elapsed;
    _stop(requestOptions);
    final status = response.statusCode ?? 0;

    _write(
      _formatBlock(
        title: 'RESPONSE #${_requestId(requestOptions)} ${_duration(elapsed)}',
        icon: status >= 200 && status < 300 ? '◀' : '⚠',
        lines: [
          '${requestOptions.method.toUpperCase()} ${_redactUri(requestOptions.uri)}',
          'Status: $status${response.statusMessage == null ? '' : ' ${response.statusMessage}'}',
        ],
        body: _formatPayload(response.data),
      ),
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final requestOptions = err.requestOptions;
    final elapsed = _stopwatch(requestOptions)?.elapsed;
    _stop(requestOptions);
    final response = err.response;

    _write(
      _formatBlock(
        title: 'ERROR #${_requestId(requestOptions)} ${_duration(elapsed)}',
        icon: '✖',
        lines: [
          '${requestOptions.method.toUpperCase()} ${_redactUri(requestOptions.uri)}',
          'Type: ${err.type.name}',
          if (response?.statusCode != null) 'Status: ${response!.statusCode}',
          if (err.message != null && err.message!.isNotEmpty)
            'Message: ${err.message}',
        ],
        body: response?.data == null ? null : _formatPayload(response!.data),
      ),
    );
    handler.next(err);
  }

  void _write(String message) {
    if (kDebugMode) {
      // Keep payload lines untouched so a JSON body can be copied directly.
      debugPrintSynchronously(message);
    }
  }

  String _formatBlock({
    required String title,
    required String icon,
    required List<String> lines,
    String? body,
  }) {
    final output = <String>['╭─ Agnes API $icon $title'];
    output.addAll(lines.map((line) => '│ $line'));
    if (body != null) {
      output.add('│ Body (copyable):');
      output.add(body);
    }
    output.add('╰────────────────────────────────────────────────────────');
    return output.join('\n');
  }

  List<String> _formatHeaders(Map<String, dynamic> headers) {
    if (headers.isEmpty) return const ['Headers: <none>'];
    final entries = headers.entries.toList()
      ..sort((left, right) => left.key.compareTo(right.key));
    return [
      'Headers:',
      for (final entry in entries)
        '  ${entry.key}: ${_isSensitiveName(entry.key) ? '<redacted>' : entry.value}',
    ];
  }

  String _formatPayload(Object? payload) {
    if (payload == null) return '<none>';
    if (payload is FormData) {
      return '<multipart form: ${payload.fields.length} fields, '
          '${payload.files.length} files>';
    }
    if (payload is List<int>) {
      return '<binary payload: ${payload.length} bytes>';
    }

    final formatted = switch (payload) {
      String value => value,
      Map() || List() => _prettyJson(payload),
      _ => payload.toString(),
    };
    return _truncate(formatted);
  }

  String _prettyJson(Object payload) {
    try {
      return const JsonEncoder.withIndent('  ').convert(payload);
    } on Object {
      return payload.toString();
    }
  }

  String _redactUri(Uri uri) {
    if (uri.queryParameters.isEmpty) return uri.toString();
    final redactedQuery = <String, String>{
      for (final entry in uri.queryParameters.entries)
        entry.key: _isSensitiveName(entry.key) ? '<redacted>' : entry.value,
    };
    return uri.replace(queryParameters: redactedQuery).toString();
  }

  String _truncate(String value) {
    if (value.length <= _maxPayloadLength) return value;
    return '${value.substring(0, _maxPayloadLength)}\n… '
        '(${value.length} characters total; output truncated)';
  }

  Stopwatch? _stopwatch(RequestOptions options) {
    final value = options.extra[_stopwatchKey];
    return value is Stopwatch ? value : null;
  }

  void _stop(RequestOptions options) {
    final stopwatch = _stopwatch(options);
    if (stopwatch != null && stopwatch.isRunning) stopwatch.stop();
  }

  String _requestId(RequestOptions options) {
    final value = options.extra[_requestIdKey];
    return value is int ? value.toString().padLeft(3, '0') : '???';
  }

  String _duration(Duration? duration) {
    if (duration == null) return 'time n/a';
    return '${duration.inMilliseconds} ms';
  }

  bool _isSensitiveName(String name) {
    final normalized = name.toLowerCase().replaceAll('-', '_');
    return normalized == 'authorization' ||
        normalized == 'proxy_authorization' ||
        normalized == 'api_key' ||
        normalized == 'access_token' ||
        normalized == 'refresh_token' ||
        normalized == 'token' ||
        normalized == 'secret' ||
        normalized == 'password' ||
        normalized == 'key';
  }
}
