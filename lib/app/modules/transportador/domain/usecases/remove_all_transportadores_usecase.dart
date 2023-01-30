import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/transportador/domain/repositories/transportador_repository.dart';
import 'package:result_dart/result_dart.dart';

abstract class IRemoveAllTransportadorUseCase {
  Future<Result<bool, IMyException>> call();
}

class RemoveAllTransportadorUseCase implements IRemoveAllTransportadorUseCase {
  final ITransportadorRepository repository;

  RemoveAllTransportadorUseCase({required this.repository});

  @override
  Future<Result<bool, IMyException>> call() async {
    return await repository.removeAll();
  }
}
