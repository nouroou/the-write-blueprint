import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_write_blueprint/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:the_write_blueprint/core/usecase/usecase.dart';
import 'package:the_write_blueprint/core/common/entities/user.dart';
import 'package:the_write_blueprint/features/auth/domain/usecases/current_user.dart';
import 'package:the_write_blueprint/features/auth/domain/usecases/user_signup.dart';
import 'package:the_write_blueprint/features/auth/domain/usecases/user_signin.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserSignin _userSignin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignup userSignup,
    required UserSignin userSignin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignup = userSignup,
        _userSignin = userSignin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignup>(_onAuthSignup);
    on<AuthSignin>(_onAuthSignin);
    on<AuthUserLoggedIn>(_isUserLoggedIn);
  }

  void _isUserLoggedIn(AuthUserLoggedIn event, Emitter<AuthState> emit) async {
    final result = await _currentUser(NoParams());

    result.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _onAuthSignup(AuthSignup event, Emitter<AuthState> emit) async {
    final response = await _userSignup(
      UserSignupParams(
        email: event.email,
        password: event.password,
        username: event.username,
        name: event.name,
        avatarUrl: event.avatarUrl,
      ),
    );
    response.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _onAuthSignin(AuthSignin event, Emitter<AuthState> emit) async {
    final response = await _userSignin(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );
    response.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
