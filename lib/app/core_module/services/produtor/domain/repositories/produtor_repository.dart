import 'package:agil_coletas/app/core_module/services/produtor/domain/entities/produtor.dart';
import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:result_dart/result_dart.dart';

abstract class IProdutorRepository {
  Future<Result<List<Produtor>, IMyException>> getProdutores();
  Future<Result<bool, IMyException>> saveProdutores(List<Produtor> produtores);
  Future<Result<bool, IMyException>> removeAll();
}
