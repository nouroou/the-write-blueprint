part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignup extends AuthEvent {
  final String email, password, name, username, avatarUrl;

  AuthSignup({
    required this.email,
    required this.password,
    required this.name,
    required this.username,
    required this.avatarUrl,
  });
}

final class AuthSignin extends AuthEvent {
  final String email, password;

  AuthSignin({
    required this.email,
    required this.password,
  });
}

final class AuthUserLoggedIn extends AuthEvent {}
