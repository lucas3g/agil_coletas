// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';
import 'package:agil_coletas/app/modules/tikets/domain/vos/produtor.dart';

abstract class TiketEvents {}

class GetProdutoresEvent extends TiketEvents {
  final int codRota;

  GetProdutoresEvent({
    required this.codRota,
  });
}

class SaveProdutoresEvent extends TiketEvents {
  final List<Produtor> produtores;

  SaveProdutoresEvent({
    required this.produtores,
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
