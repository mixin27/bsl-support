/// Base class for all all client-side errors that can be generated by the app
sealed class AppException implements Exception {
  AppException(this.message);

  final String message;

  @override
  String toString() => message;
}

class ServerException extends AppException {
  ServerException(
    String? message,
  ) : super(message ?? "Something went wrong! Please try again.");
}

class ConnectionException extends ServerException {
  ConnectionException([String? message])
      : super(
          message ?? 'No internet connection.',
        );
}

class UnknownException extends ServerException {
  UnknownException([String? message])
      : super(
          message ?? 'Something went wrong! Please try again.',
        );
}
