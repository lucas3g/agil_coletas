import 'package:agil_coletas/app/modules/auth/domain/usecases/signout_user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:agil_coletas/app/modules/auth/domain/usecases/signin_user_usecase.dart';
import 'package:agil_coletas/app/modules/auth/presenter/bloc/events/auth_events.dart';
import 'package:agil_coletas/app/modules/auth/presenter/bloc/states/auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final ISignInUserUseCase signInUserUseCase;

  final ISignOutUserUseCase signOutUserUseCase;

  AuthBloc({
    required this.signInUserUseCase,
    required this.signOutUserUseCase,
  }) : super(InitialAuth()) {
    on<SignInAuthEvent>(_signIn);

    on<SignOutUserEvent>(_signOut);
  }

  Future _signIn(SignInAuthEvent event, emit) async {
    emit(LoadingAuth());

    final result = await signInUserUseCase(event.user);

    result.fold(
      (success) => emit(SuccessAuth(funcionario: success)),
      (failure) => emit(ErrorAuth(message: failure.message)),
    );
  }

  Future _signOut(SignOutUserEvent event, emit) async {
    emit(LoadingAuth());

    final result = await signOutUserUseCase();

    await Future.delayed(const Duration(milliseconds: 500));

    result.fold(
      (success) => emit(SuccessSignOutAuth()),
      (failure) => emit(ErrorAuth(message: failure.message)),
    );
  }
}
