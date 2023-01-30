import 'dart:convert';

import 'package:agil_coletas/app/core_module/services/connectivity/connectivity_service.dart';
import 'package:agil_coletas/app/modules/transportador/domain/entities/transportador.dart';
import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/transportador/domain/repositories/transportador_repository.dart';
import 'package:agil_coletas/app/modules/transportador/infra/adapters/transportador_adapter.dart';
import 'package:agil_coletas/app/modules/transportador/infra/datasources/transportador_datasouce.dart';
import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

class TransportadorRepository implements ITransportadorRepository {
  final ITransportadorDatasource datasource;

  TransportadorRepository({required this.datasource});

  @override
  Future<Result<List<Transportador>, IMyException>> getTransportador() async {
    try {
      late List result = [];

      if (await ConnectivityService.hasWiFi()) {
        result = jsonDecode(await datasource.getTransportadorOnline());
      } else {
        result = await datasource.getTransportadorOffline();
      }

      final trans = result.map(TransportadorAdapter.fromMap).toList();

      final ultimo = await datasource.getUltimoTransportador();

      if (ultimo.isNotEmpty) {
        trans.firstWhere((e) => e.placa == ultimo).setUltimo(true);
      }

      return trans.toSuccess();
    } on DioError catch (e) {
      return MyException(message: e.message).toFailure();
    } on IMyException catch (e) {
      return MyException(message: e.message).toFailure();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<bool, IMyException>> saveTransportador(
      List<Transportador> transportadores) async {
    try {
      final result = await datasource.saveTransportadores(transportadores);

      return result.toSuccess();
    } on IMyException catch (e) {
      return MyException(message: e.message).toFailure();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<bool, IMyException>> removeAll() async {
    try {
      final result = await datasource.removeAll();

      return result.toSuccess();
    } on IMyException catch (e) {
      return MyException(message: e.message).toFailure();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }
}
