import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';
import 'package:agil_coletas/app/modules/tikets/domain/entities/tiket.dart';
import 'package:agil_coletas/app/modules/tikets/domain/vos/produtor.dart';
import 'package:result_dart/result_dart.dart';

abstract class ITiketRepository {
  Future<Result<List<Produtor>, IMyException>> getProdutores(int codRota);
  Future<Result<bool, IMyException>> saveProdutores(List<Produtor> produtores);

  //Tikets
  Future<Result<List<Tiket>, IMyException>> getTikets(int idColeta);
  Future<Result<int, IMyException>> createTikets(
      List<Produtor> produtores, Coletas coleta);
}
