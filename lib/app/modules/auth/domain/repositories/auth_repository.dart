import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/auth/domain/entities/funcionario.dart';
import 'package:agil_coletas/app/modules/auth/domain/entities/user.dart';
import 'package:result_dart/result_dart.dart';

abstract class IAuthRepository {
  Future<Result<Funcionario, IMyException>> signinUser(User user);
  Future<Result<bool, IMyException>> signOutUser();
}
