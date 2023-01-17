// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';

import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/tikets/domain/entities/tiket.dart';
import 'package:agil_coletas/app/modules/tikets/domain/repositories/tiket_repository.dart';

abstract class IGetTiketByColetaUseCase {
  Future<Result<List<Tiket>, IMyException>> call(int idColeta);
}

class GetTiketByColetaUseCase implements IGetTiketByColetaUseCase {
  final ITiketRepository repository;

  GetTiketByColetaUseCase({
    required this.repository,
  });
  @override
  Future<Result<List<Tiket>, IMyException>> call(int idColeta) async {
    return await repository.getTikets(idColeta);
  }
}
