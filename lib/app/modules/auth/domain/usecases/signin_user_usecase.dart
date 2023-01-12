// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/auth/domain/entities/user.dart';
import 'package:agil_coletas/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:result_dart/result_dart.dart';

abstract class ISignInUserUseCase {
  AsyncResult<User, IMyException> call(User user);
}

class SignInUserUseCase implements ISignInUserUseCase {
  final IAuthRepository repository;

  SignInUserUseCase({required this.repository});

  @override
  AsyncResult<User, IMyException> call(User user) {
    return user
        .validate()
        .mapError<IMyException>((error) => MyException(message: error))
        .toAsyncResult()
        .flatMap(repository.signinUser);
  }
}
