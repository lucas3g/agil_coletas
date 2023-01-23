// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/entity/impressoras.dart';

abstract class ImpressoraStates {
  final List<Impressoras> impressoras;

  ImpressoraStates({
    required this.impressoras,
  });

  SuccessGetImpressora successGet({List<Impressoras>? impressoras}) {
    return SuccessGetImpressora(impressoras: impressoras ?? this.impressoras);
  }

  LoadingImpressora loadingGet() {
    return LoadingImpressora(impressoras: impressoras);
  }

  LoadingConnectImpressora loadingConnect() {
    return LoadingConnectImpressora(impressoras: impressoras);
  }

  SuccessDisconnectImpressora successDisconnect() {
    return SuccessDisconnectImpressora(impressoras: impressoras);
  }

  SuccessConnectImpressora successConnect(Impressoras imp) {
    return SuccessConnectImpressora(imp: imp, impressoras: impressoras);
  }

  ErrorImpressora error(String message) {
    return ErrorImpressora(message: message, impressoras: impressoras);
  }

  ImprimindoTiket imprimindoTiket() {
    return ImprimindoTiket(impressoras: impressoras);
  }

  SuccessImpressaoTiket successImpressaoTiket() {
    return SuccessImpressaoTiket(impressoras: impressoras);
  }
}

class InitialImpressora extends ImpressoraStates {
  InitialImpressora() : super(impressoras: []);
}

class LoadingImpressora extends ImpressoraStates {
  LoadingImpressora({required super.impressoras});
}

class LoadingConnectImpressora extends ImpressoraStates {
  LoadingConnectImpressora({required super.impressoras});
}

class SuccessGetImpressora extends ImpressoraStates {
  SuccessGetImpressora({required super.impressoras});
}

class SuccessConnectImpressora extends ImpressoraStates {
  final Impressoras imp;

  SuccessConnectImpressora({
    required this.imp,
    required super.impressoras,
  });
}

class SuccessDisconnectImpressora extends ImpressoraStates {
  SuccessDisconnectImpressora({required super.impressoras});
}

class ErrorImpressora extends ImpressoraStates {
  final String message;

  ErrorImpressora({
    required this.message,
    required super.impressoras,
  });
}

class ImprimindoTiket extends ImpressoraStates {
  ImprimindoTiket({required super.impressoras});
}

class SuccessImpressaoTiket extends ImpressoraStates {
  SuccessImpressaoTiket({required super.impressoras});
}
