// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:agil_coletas/app/modules/auth/domain/usecases/signin_user_usecase.dart';
import 'package:agil_coletas/app/modules/auth/presenter/bloc/events/auth_events.dart';
import 'package:agil_coletas/app/modules/auth/presenter/bloc/states/auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final ISignInUserUseCase useCase;

  AuthBloc({
    required this.useCase,
  }) : super(InitialAuth()) {
    on<SignInAuthEvent>(_signIn);
  }

  Future _signIn(SignInAuthEvent event, emit) async {
    emit(LoadingAuth());

    final result = await useCase(event.user);

    result.fold(
      (success) => emit(SuccessAuth(funcionario: success)),
      (failure) => emit(ErrorAuth(message: failure.message)),
    );
  }
}
