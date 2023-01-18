import 'package:result_dart/result_dart.dart';

import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/rotas/domain/entities/rotas.dart';
import 'package:agil_coletas/app/modules/rotas/domain/repositories/rotas_repository.dart';

abstract class ISaveRotasUseCase {
  Future<Result<bool, IMyException>> call(List<Rotas> rotas);
}

class SaveRotasUseCase implements ISaveRotasUseCase {
  final IRotasRepository repository;

  SaveRotasUseCase({
    required this.repository,
  });

  @override
  Future<Result<bool, IMyException>> call(List<Rotas> rotas) async {
    return repository.saveRotas(rotas);
  }
}
