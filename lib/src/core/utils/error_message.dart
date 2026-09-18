import '../network/api_exception.dart';

String readableErrorMessage(Object error) {
  if (error is ApiException) return error.message;
  return '发生未预期的错误：$error';
}
