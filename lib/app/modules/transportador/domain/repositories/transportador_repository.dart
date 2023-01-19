import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/transportador/domain/entities/transportador.dart';
import 'package:result_dart/result_dart.dart';

abstract class ITransportadorRepository {
  Future<Result<List<Transportador>, IMyException>> getTransportador();
  Future<Result<bool, IMyException>> saveTransportador(
      List<Transportador> transportadores);
}
