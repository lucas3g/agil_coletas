// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/entity/impressoras.dart';
import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';
import 'package:agil_coletas/app/modules/tikets/domain/entities/tiket.dart';

abstract class ImpressoraEvents {}

class GetImpressorasEvent extends ImpressoraEvents {}

class ConnectImpressoraEvent extends ImpressoraEvents {
  final Impressoras imp;

  ConnectImpressoraEvent({
    required this.imp,
  });
}

class DisconnectImpressoraEvent extends ImpressoraEvents {
  final Impressoras imp;

  DisconnectImpressoraEvent({
    required this.imp,
  });
}

class ImprimirPaginaTesteEvent extends ImpressoraEvents {}

class SaveImpressoraLocalStorageEvent extends ImpressoraEvents {
  final Impressoras imp;

  SaveImpressoraLocalStorageEvent({
    required this.imp,
  });
}

class RemoveImpressoraLocalStorageEvent extends ImpressoraEvents {
  RemoveImpressoraLocalStorageEvent();
}

class GetImpressoraConectadaLocalStorageEvent extends ImpressoraEvents {
  GetImpressoraConectadaLocalStorageEvent();
}

class ImprimirTiketEvent extends ImpressoraEvents {
  final Tiket tiket;

  ImprimirTiketEvent(
    this.tiket,
  );
}

class ImprimirRotaFinalizadaEvent extends ImpressoraEvents {
  final Coletas coleta;

  ImprimirRotaFinalizadaEvent(
    this.coleta,
  );
}

class VerificaStatusImpressoraEvent extends ImpressoraEvents {
  VerificaStatusImpressoraEvent();
}
