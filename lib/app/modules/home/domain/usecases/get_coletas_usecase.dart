// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';

import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';
import 'package:agil_coletas/app/modules/home/domain/repositories/home_repository.dart';

abstract class IGetColetasUseCase {
  Future<Result<List<Coletas>, IMyException>> call();
}

class GetColetasUseCase implements IGetColetasUseCase {
  final IHomeRepository repository;

  GetColetasUseCase({
    required this.repository,
  });

  @override
  Future<Result<List<Coletas>, IMyException>> call() async {
    return await repository.getColetas();
  }
}
