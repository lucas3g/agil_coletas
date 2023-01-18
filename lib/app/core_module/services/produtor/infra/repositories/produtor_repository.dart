// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:agil_coletas/app/core_module/services/produtor/domain/entities/produtor.dart';
import 'package:agil_coletas/app/core_module/services/produtor/domain/repositories/produtor_repository.dart';
import 'package:agil_coletas/app/core_module/services/produtor/infra/adapters/produtor_adapter.dart';
import 'package:agil_coletas/app/core_module/services/produtor/infra/datasources/produtor_datasource.dart';
import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import 'package:agil_coletas/app/core_module/types/my_exception.dart';

class ProdutorRepository implements IProdutorRepository {
  final IProdutorDatasource datasource;

  ProdutorRepository({
    required this.datasource,
  });
  @override
  Future<Result<List<Produtor>, IMyException>> getProdutores() async {
    try {
      final result = jsonDecode(await datasource.getProdutores());

      return result.map(ProdutorAdapter.fromMap).toList().toSuccess();
    } on DioError catch (e) {
      return MyException(message: e.message).toFailure();
    } on IMyException catch (e) {
      return MyException(message: e.message).toFailure();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<bool, IMyException>> saveProdutores(
      List<Produtor> produtores) async {
    try {
      final result = await datasource.saveProdutores(produtores);

      return result.toSuccess();
    } on IMyException catch (e) {
      return MyException(message: e.message).toFailure();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }
}
