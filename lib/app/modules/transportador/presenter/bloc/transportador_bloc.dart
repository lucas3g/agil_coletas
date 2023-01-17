import 'package:agil_coletas/app/modules/transportador/domain/usecases/get_transportador_usecase.dart';
import 'package:agil_coletas/app/modules/transportador/presenter/bloc/events/transportador_event.dart';
import 'package:agil_coletas/app/modules/transportador/presenter/bloc/states/transportador_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransportadorBloc extends Bloc<TransportadorEvents, TransportadorStates> {
  final IGetTransportadorUseCase getTransportadorUseCase;

  TransportadorBloc({required this.getTransportadorUseCase})
      : super(InitialTransportador()) {
    on<GetTransportadorEvent>(_getTransportadores);
  }

  Future _getTransportadores(GetTransportadorEvent event, emit) async {
    emit(state.loading());

    final result = await getTransportadorUseCase();

    result.fold(
      (success) => emit(state.success(success, '')),
      (failure) => emit(state.error(failure.message)),
    );
  }
}
