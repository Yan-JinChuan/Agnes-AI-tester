import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agnes_ai_tester/src/core/network/agnes_dio_log_interceptor.dart';

void main() {
  test('formats request and response logs while redacting secrets', () async {
    final adapter = _RecordingAdapter();
    final dio =
        Dio(
            BaseOptions(
              baseUrl: 'https://example.com/v1/',
              responseType: ResponseType.json,
            ),
          )
          ..httpClientAdapter = adapter
          ..interceptors.add(AgnesDioLogInterceptor());
    final output = <String>[];

    await runZoned(
      () async {
        await dio.post(
          'chat/completions',
          options: Options(
            headers: {
              'Authorization': 'Bearer test-secret',
              'X-Debug-Header': 'visible',
            },
          ),
          data: {'model': 'test-model', 'prompt': 'hello'},
        );
      },
      zoneSpecification: ZoneSpecification(
        print: (self, parent, zone, line) => output.add(line),
      ),
    );

    final log = output.join('\n');
    expect(log, contains('REQUEST #001'));
    expect(log, contains('RESPONSE #001'));
    expect(log, contains('POST https://example.com/v1/chat/completions'));
    expect(log, contains('Authorization: <redacted>'));
    expect(log, contains('X-Debug-Header: visible'));
    expect(log, isNot(contains('test-secret')));
    expect(log, contains('Body (copyable):\n{\n  "model": "test-model"'));
    expect(log, isNot(contains('│ {')));
    expect(log, isNot(contains('│   "model"')));
    final bodyStart =
        log.indexOf('Body (copyable):\n') + 'Body (copyable):\n'.length;
    final bodyEnd = log.indexOf('\n╰─', bodyStart);
    expect(jsonDecode(log.substring(bodyStart, bodyEnd)), {
      'model': 'test-model',
      'prompt': 'hello',
    });
    expect(log, contains('Status: 200'));
    expect(log, contains('ms'));
  });

  test('truncates oversized payloads', () async {
    final adapter = _RecordingAdapter();
    final dio = Dio(BaseOptions(responseType: ResponseType.json))
      ..httpClientAdapter = adapter
      ..interceptors.add(AgnesDioLogInterceptor());
    final output = <String>[];

    await runZoned(
      () async {
        await dio.post(
          'https://example.com/upload',
          data: {'payload': 'x' * 5000},
        );
      },
      zoneSpecification: ZoneSpecification(
        print: (self, parent, zone, line) => output.add(line),
      ),
    );

    expect(output.join('\n'), contains('output truncated'));
  });
}

class _RecordingAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      '{"ok":true}',
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
