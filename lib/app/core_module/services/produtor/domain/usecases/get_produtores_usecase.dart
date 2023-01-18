import 'package:agil_coletas/app/core_module/services/produtor/domain/entities/produtor.dart';
import 'package:agil_coletas/app/core_module/services/produtor/domain/repositories/produtor_repository.dart';
import 'package:result_dart/result_dart.dart';

import 'package:agil_coletas/app/core_module/types/my_exception.dart';

abstract class IGetProdutoresUseCase {
  Future<Result<List<Produtor>, IMyException>> call();
}

class GetProdutoresUseCase implements IGetProdutoresUseCase {
  final IProdutorRepository repository;

  GetProdutoresUseCase({
    required this.repository,
  });

  @override
  Future<Result<List<Produtor>, IMyException>> call() async {
    return await repository.getProdutores();
  }
}
