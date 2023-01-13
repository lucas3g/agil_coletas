// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:agil_coletas/app/modules/auth/domain/entities/funcionario.dart';
import 'package:agil_coletas/app/modules/auth/infra/adapters/funcionario_adapter.dart';
import 'package:dio/dio.dart';
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
  Future<Result<Funcionario, IMyException>> signinUser(User user) async {
    try {
      final result = await datasource.signInUser(user);

      return FuncionarioAdapter.fromMap(jsonDecode(result)).toSuccess();
    } on IMyException catch (e) {
      return MyException(message: e.message).toFailure();
    } on DioError catch (e) {
      return MyException(message: e.message).toFailure();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }
}
