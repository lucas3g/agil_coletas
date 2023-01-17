import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/transportador/domain/entities/transportador.dart';
import 'package:agil_coletas/app/modules/transportador/domain/repositories/transportador_repository.dart';
import 'package:result_dart/result_dart.dart';

abstract class IGetTransportadorUseCase {
  Future<Result<List<Transportador>, IMyException>> call();
}

class GetTransportadorUseCase implements IGetTransportadorUseCase {
  final ITransportadorRepository repository;

  GetTransportadorUseCase({required this.repository});

  @override
  Future<Result<List<Transportador>, IMyException>> call() async {
    return await repository.getTransportador();
  }
}
