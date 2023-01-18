import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';
import 'package:agil_coletas/app/modules/tikets/infra/adapters/tiket_adapter.dart';
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
  Future<Result<int, IMyException>> createTikets(Coletas coleta) async {
    try {
      final result = await datasource.createTikets(coleta);

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

      final List<Tiket> tikets = [];

      for (var tiket in result) {
        tikets.add(TiketAdapter.fromMap(tiket));
      }

      tikets.sort((a, b) => ("${a.quantidade}${a.temperatura}")
          .toString()
          .compareTo(("${b.quantidade}${b.temperatura}").toString()));

      return tikets.toSuccess();
    } on IMyException catch (e) {
      return MyException(message: e.message).toFailure();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<bool, IMyException>> updateTiket(Tiket tiket) async {
    try {
      final result = await datasource.updateTiket(tiket);

      return result.toSuccess();
    } on IMyException catch (e) {
      return MyException(message: e.message).toFailure();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }
}
