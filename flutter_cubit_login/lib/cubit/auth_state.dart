import 'package:equatable/equatable.dart';

import '../data/user.dart';

abstract class AuthState{
  const AuthState();
}

class AuthInitial extends AuthState{
  const AuthInitial();
}

class AuthLoading extends AuthState{
  const AuthLoading();
}

class AuthSuccess extends AuthState{
  final User user;
  const AuthSuccess({required this.user});

  String get() => user.username;
}

class AuthError extends AuthState{
  final String message;
  AuthError({required this.message});
}

