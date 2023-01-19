import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:result_dart/result_dart.dart';

abstract class ISendRepository {
  Future<Result<bool, IMyException>> sendColetaToSever();
}
