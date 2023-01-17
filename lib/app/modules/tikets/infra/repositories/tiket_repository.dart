import 'dart:convert';

import 'package:agil_coletas/app/core_module/services/connectivity/connectivity_service.dart';
import 'package:agil_coletas/app/modules/tikets/domain/vos/produtor.dart';
import 'package:agil_coletas/app/modules/tikets/infra/adapters/produtor_adapter.dart';
import 'package:agil_coletas/app/modules/tikets/infra/adapters/tiket_adapter.dart';
import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/tikets/domain/entities/tiket.dart';
import 'package:agil_coletas/app/modules/tikets/domain/repositories/tiket_repository.dart';
import 'package:agil_coletas/app/modules/tikets/infra/datasources/tiket_datasource.dart';

class TiketRepository implements ITiketRepository {
  final ITiketDatasource datasource;

  TiketRepository({
    required this.datasource,
  });

  @override
  Future<Result<bool, IMyException>> createTikets(
      List<Produtor> produtores) async {
    try {
      final result = await datasource.createTikets(produtores);

      return result.toSuccess();
    } on IMyException catch (e) {
      return MyException(message: e.message).toFailure();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<List<Tiket>, IMyException>> getTikets(int idColeta) async {
    try {
      final result = await datasource.getTikets(idColeta);

      return result.map(TiketAdapter.fromMap).toList().toSuccess();
    } on IMyException catch (e) {
      return MyException(message: e.message).toFailure();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<List<Produtor>, IMyException>> getProdutores(
      int codRota) async {
    try {
      late List result = [];

      if (await ConnectivityService.hasWiFi()) {
        result = jsonDecode(await datasource.getProdutoresOnline());
      } else {
        result = await datasource.getProdutoresOffline(codRota);
      }

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
