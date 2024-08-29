import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignUp;
  AuthBloc({
    required UserSignup userSignUp,
  })  : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      // bloc depend on usecase
      on<AuthSignUp>((event, emit) async {
        emit(AuthLoading());
        final res = await _userSignUp(UserSignUpparams(
            email: event.email, password: event.password, name: event.name));
        res.fold((l) => emit(AuthFailure(l.message)),
            (user) => emit(AuthSuccess(user)));
      });
    });
  }
}
