// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/modules/auth/infra/adapters/user_adapter.dart';
import 'package:result_dart/result_dart.dart';

import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/auth/domain/entities/user.dart';
import 'package:agil_coletas/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:agil_coletas/app/modules/auth/infra/datasources/auth_datasource.dart';

class AuthRepository implements IAuthRepository {
  final IAuthDatasource datasource;

  AuthRepository({
    required this.datasource,
  });

  @override
  Future<Result<User, IMyException>> signinUser(User user) async {
    try {
      final result = await datasource.signInUser(user);

      return UserAdapter.fromMap(result).toSuccess();
    } on IMyException catch (e) {
      return MyException(message: e.message).toFailure();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }
}
