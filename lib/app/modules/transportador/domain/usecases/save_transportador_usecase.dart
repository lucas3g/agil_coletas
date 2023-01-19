import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/transportador/domain/entities/transportador.dart';
import 'package:agil_coletas/app/modules/transportador/domain/repositories/transportador_repository.dart';
import 'package:result_dart/result_dart.dart';

abstract class ISaveTransportadorUseCase {
  Future<Result<bool, IMyException>> call(List<Transportador> transportadores);
}

class SaveTransportadorUseCase implements ISaveTransportadorUseCase {
  final ITransportadorRepository repository;

  SaveTransportadorUseCase({required this.repository});

  @override
  Future<Result<bool, IMyException>> call(
      List<Transportador> transportadores) async {
    return await repository.saveTransportador(transportadores);
  }
}
