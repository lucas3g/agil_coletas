// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:agil_coletas/app/modules/tikets/domain/usecases/create_tikets_by_coleta_usecase.dart';
import 'package:agil_coletas/app/modules/tikets/domain/usecases/get_tikets_by_coleta_usecase.dart';
import 'package:agil_coletas/app/modules/tikets/presenter/bloc/events/tiket_events.dart';
import 'package:agil_coletas/app/modules/tikets/presenter/bloc/states/tiket_states.dart';

class TiketBloc extends Bloc<TiketEvents, TiketStates> {
  final IGetTiketByColetaUseCase getTiketByColetaUseCase;
  final ICreateTiketByColetaUseCase createTiketByColetaUseCase;

  TiketBloc({
    required this.getTiketByColetaUseCase,
    required this.createTiketByColetaUseCase,
  }) : super(InitialTiket()) {
    on<GetTiketsEvent>(_getTikets);
    on<CreateTiketsEvent>(_createTikets);
  }

  Future _getTikets(GetTiketsEvent event, emit) async {
    emit(LoadingTiket());

    final result = await getTiketByColetaUseCase(event.codColeta);

    result.fold(
      (success) => emit(SuccessGetTikets(tikets: success)),
      (failure) => emit(ErrorTiket(message: failure.message)),
    );
  }

  Future _createTikets(CreateTiketsEvent event, emit) async {
    emit(LoadingTiket());

    final result = await createTiketByColetaUseCase(event.coleta);

    result.fold(
      (success) => emit(SuccessCreateTiket(codColeta: success)),
      (failure) => emit(ErrorTiket(message: failure.message)),
    );
  }
}
