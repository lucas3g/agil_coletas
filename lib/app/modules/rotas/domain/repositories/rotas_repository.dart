import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/rotas/domain/entities/rotas.dart';
import 'package:result_dart/result_dart.dart';

abstract class IRotasRepository {
  Future<Result<List<Rotas>, IMyException>> getRotas();
}
