sealed class AppException implements Exception {
  AppException(this.message);

  final String message;

  @override
  String toString() => message;
}

class WrongPasswordException extends AppException {
  WrongPasswordException() : super('Wrong password.');
}

class UserNotFoundException extends AppException {
  UserNotFoundException() : super('User not found.');
}
