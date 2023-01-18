// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';
import 'package:agil_coletas/app/modules/tikets/domain/entities/tiket.dart';

abstract class TiketEvents {}

class GetProdutoresEvent extends TiketEvents {
  final int codRota;

  GetProdutoresEvent({
    required this.codRota,
  });
}

class CreateTiketsEvent extends TiketEvents {
  final Coletas coleta;

  CreateTiketsEvent({
    required this.coleta,
  });
}

class GetTiketsEvent extends TiketEvents {
  final int codColeta;

  GetTiketsEvent({
    required this.codColeta,
  });
}

class UpdateTiketEvent extends TiketEvents {
  final Tiket tiket;

  UpdateTiketEvent({
    required this.tiket,
  });
}

class FilterTiketsEvent extends TiketEvents {
  final String filtro;

  FilterTiketsEvent({
    required this.filtro,
  });
}
