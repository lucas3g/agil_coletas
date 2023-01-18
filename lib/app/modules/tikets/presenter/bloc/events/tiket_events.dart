import 'package:agil_coletas/app/core_module/services/produtor/domain/entities/produtor.dart';
import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';

abstract class TiketEvents {}

class GetProdutoresEvent extends TiketEvents {
  final int codRota;

  GetProdutoresEvent({
    required this.codRota,
  });
}

class CreateTiketsEvent extends TiketEvents {
  final List<Produtor> produtores;
  final Coletas coleta;

  CreateTiketsEvent({
    required this.produtores,
    required this.coleta,
  });
}

class GetTiketsEvent extends TiketEvents {
  final int codColeta;

  GetTiketsEvent({
    required this.codColeta,
  });
}
