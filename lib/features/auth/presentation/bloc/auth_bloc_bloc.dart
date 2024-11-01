import 'package:blog_app/features/auth/domain/usercases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final UserSignUp _userSignUp;
  AuthBlocBloc({
    required UserSignUp userSignUp,
  })  : _userSignUp = userSignUp,
        super(AuthBlocInitial()) {
    on<AuthSignUp>((event, emit) async {
      final res = await _userSignUp(UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ));
      res.fold((l) => emit(AuthFailure(message: l.message)),
          (r) => emit(AuthSuccess(uid: r)));
    });
  }
}
