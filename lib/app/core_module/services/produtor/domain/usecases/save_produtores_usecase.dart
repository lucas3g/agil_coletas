// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/core_module/services/produtor/domain/entities/produtor.dart';
import 'package:agil_coletas/app/core_module/services/produtor/domain/repositories/produtor_repository.dart';
import 'package:result_dart/result_dart.dart';

import 'package:agil_coletas/app/core_module/types/my_exception.dart';

abstract class ISaveProdutoresUseCase {
  Future<Result<bool, IMyException>> call(List<Produtor> produtores);
}

class SaveProdutoresUseCase implements ISaveProdutoresUseCase {
  final IProdutorRepository repository;

  SaveProdutoresUseCase({
    required this.repository,
  });

  @override
  Future<Result<bool, IMyException>> call(List<Produtor> produtores) async {
    return await repository.saveProdutores(produtores);
  }
}
