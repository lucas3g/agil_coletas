import 'package:agil_coletas/app/modules/transportador/domain/entities/transportador.dart';
import 'package:agil_coletas/app/utils/formatters.dart';

abstract class TransportadorStates {
  final List<Transportador> transportadores;
  final String filtro;

  TransportadorStates({required this.transportadores, required this.filtro});

  SuccessGetTransportador success(
      {List<Transportador>? transportadores, String? filtro}) {
    return SuccessGetTransportador(
      transportadores: transportadores ?? this.transportadores,
      filtro: filtro ?? this.filtro,
    );
  }

  SuccessSaveTransportador successSave() {
    return SuccessSaveTransportador(
        transportadores: transportadores, filtro: filtro);
  }

  LoadingTransportador loading() {
    return LoadingTransportador(
        transportadores: transportadores, filtro: filtro);
  }

  ErrorTransportador error(String message) {
    return ErrorTransportador(
        message: message, transportadores: transportadores, filtro: filtro);
  }

  List<Transportador> get transpFiltrados {
    if (filtro.isEmpty) {
      return transportadores;
    }

    return transportadores
        .where(
          (transp) => (transp.descricao
                  .toLowerCase()
                  .removeAcentos()
                  .contains(filtro.toLowerCase().removeAcentos()) ||
              transp.placa
                  .toLowerCase()
                  .removeAcentos()
                  .contains(filtro.toLowerCase().removeAcentos())),
        )
        .toList();
  }
}

class InitialTransportador extends TransportadorStates {
  InitialTransportador() : super(transportadores: [], filtro: '');
}

class LoadingTransportador extends TransportadorStates {
  LoadingTransportador({required super.transportadores, required super.filtro});
}

class SuccessGetTransportador extends TransportadorStates {
  SuccessGetTransportador(
      {required super.transportadores, required super.filtro});
}

class SuccessSaveTransportador extends TransportadorStates {
  SuccessSaveTransportador(
      {required super.transportadores, required super.filtro});
}

class ErrorTransportador extends TransportadorStates {
  final String message;

  ErrorTransportador({
    required this.message,
    required super.transportadores,
    required super.filtro,
  });
}
