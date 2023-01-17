// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';

import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/tikets/domain/repositories/tiket_repository.dart';
import 'package:agil_coletas/app/modules/tikets/domain/vos/produtor.dart';

abstract class IGetProdutoresUseCase {
  Future<Result<List<Produtor>, IMyException>> call(int codRota);
}

class GetProdutoresUseCase implements IGetProdutoresUseCase {
  final ITiketRepository repository;

  GetProdutoresUseCase({
    required this.repository,
  });

  @override
  Future<Result<List<Produtor>, IMyException>> call(int codRota) async {
    return await repository.getProdutores(codRota);
  }
}
