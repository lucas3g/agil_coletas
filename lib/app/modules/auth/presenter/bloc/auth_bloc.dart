// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/modules/auth/domain/usecases/signout_user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:agil_coletas/app/core_module/services/license/domain/usecases/get_date_license_usecase.dart';
import 'package:agil_coletas/app/core_module/services/license/domain/usecases/save_license_usecase.dart';
import 'package:agil_coletas/app/core_module/services/license/domain/usecases/verify_license_usecase.dart';
import 'package:agil_coletas/app/modules/auth/domain/usecases/signin_user_usecase.dart';
import 'package:agil_coletas/app/modules/auth/presenter/bloc/events/auth_events.dart';
import 'package:agil_coletas/app/modules/auth/presenter/bloc/states/auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final ISignInUserUseCase signInUserUseCase;
  final IVerifyLicenseUseCase verifyLicenseUseCase;
  final ISaveLicenseUseCase saveLicenseUseCase;
  final IGetDateLicenseUseCase getDateLicenseUseCase;
  final ISignOutUserUseCase signOutUserUseCase;

  AuthBloc({
    required this.signInUserUseCase,
    required this.verifyLicenseUseCase,
    required this.saveLicenseUseCase,
    required this.getDateLicenseUseCase,
    required this.signOutUserUseCase,
  }) : super(InitialAuth()) {
    on<SignInAuthEvent>(_signIn);
    on<VerifyLicenseEvent>(_verifyLicense);
    on<SaveLicenseEvent>(_saveLicense);
    on<GetDateLicenseEvent>(_getDateLicense);
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

  Future _verifyLicense(VerifyLicenseEvent event, emit) async {
    emit(LoadingAuth());

    final result = await verifyLicenseUseCase(event.deviceInfo);

    result.fold(
      (success) {
        if (success.ativa == 'S') {
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

  Future _getDateLicense(GetDateLicenseEvent event, emit) async {
    emit(LoadingAuth());

    final result = await getDateLicenseUseCase();

    result.fold(
      (success) => emit(DateLicenseAuth(dateTime: success)),
      (failure) => emit(ErrorAuth(message: failure.message)),
    );
  }

  Future _saveLicense(SaveLicenseEvent event, emit) async {
    await saveLicenseUseCase();
  }
}
