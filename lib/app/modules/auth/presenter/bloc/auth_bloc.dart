// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:agil_coletas/app/core_module/services/license/domain/usecases/save_license_usecase.dart';
import 'package:agil_coletas/app/core_module/services/license/domain/usecases/verify_license_usecase.dart';
import 'package:agil_coletas/app/modules/auth/domain/usecases/signin_user_usecase.dart';
import 'package:agil_coletas/app/modules/auth/presenter/bloc/events/auth_events.dart';
import 'package:agil_coletas/app/modules/auth/presenter/bloc/states/auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final ISignInUserUseCase signInUserUseCase;
  final IVerifyLicenseUseCase verifyLicenseUseCase;
  final ISaveLicenseUseCase saveLicenseUseCase;

  AuthBloc({
    required this.signInUserUseCase,
    required this.verifyLicenseUseCase,
    required this.saveLicenseUseCase,
  }) : super(InitialAuth()) {
    on<SignInAuthEvent>(_signIn);
    on<VerifyLicenseEvent>(_verifyLicense);
  }

  Future _signIn(SignInAuthEvent event, emit) async {
    emit(LoadingAuth());

    final result = await signInUserUseCase(event.user);

    result.fold(
      (success) => emit(SuccessAuth(funcionario: success)),
      (failure) => emit(ErrorAuth(message: failure.message)),
    );
  }

  Future _verifyLicense(VerifyLicenseEvent event, emit) async {
    emit(LoadingAuth());

    final result = await verifyLicenseUseCase(event.deviceInfo);

    result.fold(
      (success) async {
        if (success.ativa == 'S') {
          await saveLicenseUseCase();
          return emit(LicenseActiveAuth());
        }

        if (success.ativa == 'N') {
          return emit(LicenseNotActiveAuth());
        }

        return emit(LicenseNotFoundAuth());
      },
      (failure) => emit(ErrorAuth(message: failure.message)),
    );
  }
}
