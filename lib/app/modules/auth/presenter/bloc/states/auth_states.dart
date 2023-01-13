// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/modules/auth/domain/entities/funcionario.dart';

abstract class AuthStates {}

class InitialAuth extends AuthStates {}

class LoadingAuth extends AuthStates {}

class SuccessAuth extends AuthStates {
  final Funcionario funcionario;

  SuccessAuth({
    required this.funcionario,
  });
}

class ErrorAuth extends AuthStates {
  final String message;

  ErrorAuth({
    required this.message,
  });
}

class LicenseActiveAuth extends AuthStates {}

class LicenseNotActiveAuth extends AuthStates {}

class LicenseNotFoundAuth extends AuthStates {}
