// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:agil_coletas/app/modules/rotas/domain/usecases/get_rotas_usecase.dart';
import 'package:agil_coletas/app/modules/rotas/domain/usecases/save_rotas_usecase.dart';
import 'package:agil_coletas/app/modules/rotas/presenter/bloc/events/rotas_events.dart';
import 'package:agil_coletas/app/modules/rotas/presenter/bloc/states/rotas_states.dart';

class RotasBloc extends Bloc<RotasEvents, RotasStates> {
  final IGetRotasUseCase getRotasUseCase;
  final ISaveRotasUseCase saveRotasUseCase;

  RotasBloc({
    required this.getRotasUseCase,
    required this.saveRotasUseCase,
  }) : super(InitialRotas()) {
    on<GetRotasEvent>(_getRotas);
    on<FiltraRotasEvent>(_searchRotas);
    on<SaveRotasEvent>(_saveRotas);
  }

  Future _getRotas(GetRotasEvent event, emit) async {
    emit(state.loading());

    final result = await getRotasUseCase();

    result.fold(
      (success) => emit(state.successGet(rotas: success)),
      (failure) => emit(state.error(failure.message)),
    );
  }

  Future _saveRotas(SaveRotasEvent event, emit) async {
    emit(state.loading());

    final result = await saveRotasUseCase(event.rotas);

    result.fold(
      (success) => emit(state.successSave()),
      (failure) => emit(state.error(failure.message)),
    );
  }

  void _searchRotas(FiltraRotasEvent event, emit) {
    emit(state.successGet(filtro: event.value));
  }
}
