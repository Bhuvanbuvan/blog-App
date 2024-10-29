part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocState {
  const AuthBlocState();
}

final class AuthBlocInitial extends AuthBlocState {}

final class AuthLoading extends AuthBlocState {}

final class AuthSuccess extends AuthBlocState {
  final String uid;

  const AuthSuccess({required this.uid});
}

final class AuthFailure extends AuthBlocState {
  final String message;
  const AuthFailure({required this.message});
}
