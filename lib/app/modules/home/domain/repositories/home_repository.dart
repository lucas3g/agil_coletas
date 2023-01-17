import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';
import 'package:result_dart/result_dart.dart';

abstract class IHomeRepository {
  Future<Result<List<Coletas>, IMyException>> getColetas();
  Future<Result<Coletas, IMyException>> createColeta(Coletas coleta);
}
