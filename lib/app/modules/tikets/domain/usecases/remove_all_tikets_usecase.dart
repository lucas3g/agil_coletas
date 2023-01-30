// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';

import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/tikets/domain/repositories/tiket_repository.dart';

abstract class IRemoveAllTiketUseCase {
  Future<Result<bool, IMyException>> call();
}

class RemoveAllTiketUseCase implements IRemoveAllTiketUseCase {
  final ITiketRepository repository;

  RemoveAllTiketUseCase({
    required this.repository,
  });
  @override
  Future<Result<bool, IMyException>> call() async {
    return await repository.removeAll();
  }
}
