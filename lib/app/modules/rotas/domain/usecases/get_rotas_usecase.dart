// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';

import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/rotas/domain/entities/rotas.dart';
import 'package:agil_coletas/app/modules/rotas/domain/repositories/rotas_repository.dart';

abstract class IGetRotasUseCase {
  Future<Result<List<Rotas>, IMyException>> call();
}

class GetRotasUseCase implements IGetRotasUseCase {
  final IRotasRepository repository;

  GetRotasUseCase({
    required this.repository,
  });

  @override
  Future<Result<List<Rotas>, IMyException>> call() async {
    return await repository.getRotas();
  }
}
