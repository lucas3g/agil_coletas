// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:result_dart/result_dart.dart';

abstract class ISignOutUserUseCase {
  AsyncResult<bool, IMyException> call();
}

class SignOutUserUseCase implements ISignOutUserUseCase {
  final IAuthRepository repository;

  SignOutUserUseCase({required this.repository});

  @override
  AsyncResult<bool, IMyException> call() {
    return repository.signOutUser();
  }
}
