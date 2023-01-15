import 'package:agil_coletas/app/modules/home/infra/adapters/coletas_adapter.dart';
import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';
import 'package:agil_coletas/app/modules/home/domain/repositories/home_repository.dart';
import 'package:agil_coletas/app/modules/home/infra/datasources/home_datasource.dart';

class HomeRepository implements IHomeRepository {
  final IHomeDatasource datasource;

  HomeRepository({
    required this.datasource,
  });

  @override
  Future<Result<List<Coletas>, IMyException>> getColetas() async {
    try {
      final result = await datasource.getColetas();

      final List<Coletas> coletas = [];

      for (var coleta in result) {
        coletas.add(ColetasAdapter.fromMap(coleta));
      }

      return coletas.toSuccess();
    } on DioError catch (e) {
      return MyException(message: e.message).toFailure();
    } on MyException catch (e) {
      return MyException(message: e.message).toFailure();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }
}
