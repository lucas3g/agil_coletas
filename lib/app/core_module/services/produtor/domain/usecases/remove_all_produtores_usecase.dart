import 'package:agil_coletas/app/core_module/services/produtor/domain/repositories/produtor_repository.dart';
import 'package:result_dart/result_dart.dart';

import 'package:agil_coletas/app/core_module/types/my_exception.dart';

abstract class IRemoveAllProdutoresUseCase {
  Future<Result<bool, IMyException>> call();
}

class RemoveAllProdutoresUseCase implements IRemoveAllProdutoresUseCase {
  final IProdutorRepository repository;

  RemoveAllProdutoresUseCase({
    required this.repository,
  });

  @override
  Future<Result<bool, IMyException>> call() async {
    return await repository.removeAll();
  }
}
