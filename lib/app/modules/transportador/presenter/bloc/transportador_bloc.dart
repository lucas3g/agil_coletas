import 'package:agil_coletas/app/modules/transportador/domain/usecases/get_transportador_usecase.dart';
import 'package:agil_coletas/app/modules/transportador/domain/usecases/remove_all_transportadores_usecase.dart';
import 'package:agil_coletas/app/modules/transportador/domain/usecases/save_transportador_usecase.dart';
import 'package:agil_coletas/app/modules/transportador/presenter/bloc/events/transportador_event.dart';
import 'package:agil_coletas/app/modules/transportador/presenter/bloc/states/transportador_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransportadorBloc extends Bloc<TransportadorEvents, TransportadorStates> {
  final IGetTransportadorUseCase getTransportadorUseCase;
  final ISaveTransportadorUseCase saveTransportadorUseCase;
  final IRemoveAllTransportadorUseCase removeAllTransportadorUseCase;

  TransportadorBloc({
    required this.getTransportadorUseCase,
    required this.saveTransportadorUseCase,
    required this.removeAllTransportadorUseCase,
  }) : super(InitialTransportador()) {
    on<GetTransportadorEvent>(_getTransportadores);
    on<FiltraTransportadorEvent>(_serachTransp);
    on<SaveTransportadorEvent>(_saveTransp);
    on<RemoveAllTransportadores>(_removeAll);
  }

  Future _getTransportadores(GetTransportadorEvent event, emit) async {
    emit(state.loading());

    final result = await getTransportadorUseCase();

    result.fold(
      (success) => emit(state.success(transportadores: success, filtro: '')),
      (failure) => emit(state.error(failure.message)),
    );
  }

  Future _saveTransp(SaveTransportadorEvent event, emit) async {
    emit(state.loading());

    final result = await saveTransportadorUseCase(event.transportadores);

    result.fold(
      (success) => emit(state.successSave()),
      (failure) => emit(state.error(failure.message)),
    );
  }

  void _serachTransp(FiltraTransportadorEvent event, emit) {
    emit(state.success(filtro: event.value));
  }

  Future _removeAll(RemoveAllTransportadores event, emit) async {
    await removeAllTransportadorUseCase();
  }
}
