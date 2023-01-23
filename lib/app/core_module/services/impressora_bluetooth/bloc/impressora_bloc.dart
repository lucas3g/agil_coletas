// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/entity/impressoras.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/bloc/events/impressora_events.dart';
import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/bloc/states/impressora_state.dart';
import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/blue_thermal_printer.dart';

class ImpressoraBloc extends Bloc<ImpressoraEvents, ImpressoraStates> {
  final IBlueThermalPrinter blueThermalPrinter;

  ImpressoraBloc({
    required this.blueThermalPrinter,
  }) : super(InitialImpressora()) {
    on<GetImpressorasEvent>(_getImpressoras);
    on<ConnectImpressoraEvent>(_connectImpressora);
    on<DisconnectImpressoraEvent>(_disconnectImpressora);
    on<ImprimirPaginaTesteEvent>(_imprimirPaginaTeste);
    on<SaveImpressoraLocalStorageEvent>(_saveImpressoraLocalStorage);
    on<RemoveImpressoraLocalStorageEvent>(_removeImpressoraLocalStorage);
    on<GetImpressoraConectadaLocalStorageEvent>(
        _getImpressoraConectadaLocalStorage);
    on<ImprimirTiketEvent>(_imprimirTiket);
    on<ImprimirRotaFinalizadaEvent>(_imprimirRotaFinalizada);
  }

  Future _getImpressoras(GetImpressorasEvent event, emit) async {
    emit(state.loadingGet());

    final result = await blueThermalPrinter.getImpressoras();

    result.fold(
      (success) => emit(state.successGet(impressoras: success)),
      (failure) => emit(state.error(failure.message)),
    );
  }

  Future _connectImpressora(ConnectImpressoraEvent event, emit) async {
    emit(state.loadingConnect());

    final result = await blueThermalPrinter.connectDevice(event.imp);

    result.fold(
      (success) => emit(state.successConnect(event.imp)),
      (failure) => emit(state.error(failure.message)),
    );
  }

  Future _disconnectImpressora(DisconnectImpressoraEvent event, emit) async {
    final result = await blueThermalPrinter.disconnectDevice(event.imp);

    result.fold(
      (success) => emit(state.successDisconnect()),
      (failure) => emit(state.error(failure.message)),
    );
  }

  Future _imprimirPaginaTeste(ImprimirPaginaTesteEvent event, emit) async {
    await blueThermalPrinter.imprimirPaginaTeste();
  }

  Future _saveImpressoraLocalStorage(
      SaveImpressoraLocalStorageEvent event, emit) async {
    await blueThermalPrinter.saveImpressoraLocalStorage(event.imp);
  }

  Future _removeImpressoraLocalStorage(
      RemoveImpressoraLocalStorageEvent event, emit) async {
    await blueThermalPrinter.removeImpressoraLocalStorage();
  }

  void _getImpressoraConectadaLocalStorage(
      GetImpressoraConectadaLocalStorageEvent event, emit) {
    final result = blueThermalPrinter.getImpressoraConectada();

    final impressoras =
        List<Impressoras>.from((state as SuccessGetImpressora).impressoras);

    final imp = result.getOrNull();

    if (imp != null) {
      impressoras
          .firstWhere((e) => e.address.contains(imp.address))
          .setConnected(imp.connected);
    }
  }

  Future _imprimirTiket(ImprimirTiketEvent event, emit) async {
    emit(state.imprimindoTiket());

    final result = await blueThermalPrinter.imprimirTiket(event.tiket);

    result.fold(
      (success) => emit(state.successImpressaoTiket()),
      (failure) => emit(state.error(failure.message)),
    );
  }

  Future _imprimirRotaFinalizada(
      ImprimirRotaFinalizadaEvent event, emit) async {
    await blueThermalPrinter.imprimirRotaFinalizada(event.coleta);
  }
}
