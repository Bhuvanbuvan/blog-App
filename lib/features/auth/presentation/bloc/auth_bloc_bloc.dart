import 'dart:async';

import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/usercases/current_user_usecse.dart';
import 'package:blog_app/features/auth/domain/usercases/user_login_usecase.dart';
import 'package:blog_app/features/auth/domain/usercases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final UserLoginUsecase _loginUsecase;
  final UserSignUp _userSignUp;
  final CurrentUserUsecse _currentUserUsecse;
  AuthBlocBloc({
    required UserLoginUsecase loginUsercase,
    required UserSignUp userSignUp,
    required CurrentUserUsecse currentusercaser,
  })  : _userSignUp = userSignUp,
        _loginUsecase = loginUsercase,
        _currentUserUsecse = currentusercaser,
        super(AuthBlocInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLogedIn>(_onUserIsLogedIn);
  }

  FutureOr<void> _onUserIsLogedIn(
    AuthIsUserLogedIn event,
    Emitter<AuthBlocState> emit,
  ) async {
    final res = await _currentUserUsecse(NoParams());

    res.fold(
      (onLeft) => emit(
        AuthFailure(
          message: onLeft.message,
        ),
      ),
      (onRight) => emit(
        AuthSuccess(
          user: onRight,
        ),
      ),
    );
  }

  void _onAuthLogin(
    AuthLogin event,
    Emitter<AuthBlocState> emit,
  ) async {
    emit(AuthLoading());
    final res = await _loginUsecase(
      UserLoginIn(
        email: event.email,
        password: event.password,
      ),
    );
    res.fold(
      (failer) => emit(
        AuthFailure(message: failer.message),
      ),
      (user) => emit(
        AuthSuccess(user: user),
      ),
    );
  }

  void _onAuthSignUp(
    AuthSignUp event,
    Emitter<AuthBlocState> emit,
  ) async {
    emit(AuthLoading());
    final res = await _userSignUp(UserSignUpParams(
      email: event.email,
      password: event.password,
      name: event.name,
    ));
    res.fold(
      (l) => emit(
        AuthFailure(
          message: l.message,
        ),
      ),
      (user) => emit(
        AuthSuccess(
          user: user,
        ),
      ),
    );
  }
}
