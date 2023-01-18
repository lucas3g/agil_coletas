// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:agil_coletas/app/core_module/services/connectivity/connectivity_service.dart';
import 'package:agil_coletas/app/modules/rotas/infra/adapters/rotas_adapter.dart';
import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/rotas/domain/entities/rotas.dart';
import 'package:agil_coletas/app/modules/rotas/domain/repositories/rotas_repository.dart';
import 'package:agil_coletas/app/modules/rotas/infra/datasources/rotas_datasource.dart';

class RotasRepository implements IRotasRepository {
  final IRotasDatasource datasource;

  RotasRepository({
    required this.datasource,
  });

  @override
  Future<Result<List<Rotas>, IMyException>> getRotas() async {
    try {
      late List result = [];

      if (await ConnectivityService.hasWiFi()) {
        result = jsonDecode(await datasource.getRotasOnline());
      } else {
        result = await datasource.getRotasOffline();
      }

      late List<Rotas> rotas = [];

      for (var rota in result) {
        rotas.add(RotasAdapter.fromMap(rota));
      }

      final finalizadas = await datasource.getRotasNaoFinalizadas();

      for (var rota in finalizadas) {
        rotas
            .firstWhere((e) => e.id.value == rota['COD_ROTA'])
            .setFinalizada(false);
      }

      return rotas.toSuccess();
    } on DioError catch (e) {
      return MyException(message: e.message).toFailure();
    } on IMyException catch (e) {
      return MyException(message: e.message).toFailure();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<bool, IMyException>> saveRotas(List<Rotas> rotas) async {
    try {
      final result = jsonDecode(await datasource.getRotasOnline());

      return result.toSuccess();
    } on DioError catch (e) {
      return MyException(message: e.message).toFailure();
    } on IMyException catch (e) {
      return MyException(message: e.message).toFailure();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }
}
