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
  Future<Result<int, IMyException>> createTikets(int codRota) async {
    try {
      final result = await datasource.createTikets(codRota);

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
}
