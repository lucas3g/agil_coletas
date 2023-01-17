import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/tikets/domain/entities/tiket.dart';
import 'package:result_dart/result_dart.dart';

abstract class IGetTiketByColetaUseCase {
  Future<Result<List<Tiket>, IMyException>> call(int idColeta);
}

class GetTiketByColetaUseCase implements IGetTiketByColetaUseCase {
  @override
  Future<Result<List<Tiket>, IMyException>> call(int idColeta) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
