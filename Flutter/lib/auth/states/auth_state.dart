abstract class AuthState {}

class UnauthenticatedState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthenticatedState extends AuthState {}

class UnauthWelcomeState extends AuthState {}

class ErrorState extends AuthState {
  ErrorState(this.message);

  String message;
}

class EmailUnverifiedState extends AuthState {
  EmailUnverifiedState(this.email, this.password);

  final String email;
  final String password;
}
