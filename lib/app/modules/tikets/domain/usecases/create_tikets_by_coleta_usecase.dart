// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/modules/tikets/domain/vos/produtor.dart';
import 'package:result_dart/result_dart.dart';

import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/tikets/domain/repositories/tiket_repository.dart';

abstract class ICreateTiketByColetaUseCase {
  Future<Result<bool, IMyException>> call(List<Produtor> produtores);
}

class CreateTiketByColetaUseCase implements ICreateTiketByColetaUseCase {
  final ITiketRepository repository;

  CreateTiketByColetaUseCase({
    required this.repository,
  });
  @override
  Future<Result<bool, IMyException>> call(List<Produtor> produtores) async {
    return await repository.createTikets(produtores);
  }
}
