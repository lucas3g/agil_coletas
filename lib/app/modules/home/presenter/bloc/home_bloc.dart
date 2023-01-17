// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:agil_coletas/app/modules/home/domain/usecases/create_coleta_usecase.dart';
import 'package:agil_coletas/app/modules/home/domain/usecases/get_coletas_usecase.dart';
import 'package:agil_coletas/app/modules/home/presenter/bloc/events/home_events.dart';
import 'package:agil_coletas/app/modules/home/presenter/bloc/states/home_states.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  final IGetColetasUseCase getColetasUseCase;
  final ICreateColetasUseCase createColetasUseCase;

  HomeBloc({
    required this.getColetasUseCase,
    required this.createColetasUseCase,
  }) : super(InitialHome()) {
    on<GetColetasEvent>(_getColetas);
    on<CreateColetaEvent>(_createColeta);
  }

  Future _getColetas(GetColetasEvent event, emit) async {
    emit(LoadingHome());

    final result = await getColetasUseCase();

    result.fold(
      (success) => emit(SuccessGetColetasHome(coletas: success)),
      (failure) => emit(ErrorHome(message: failure.message)),
    );
  }

  Future _createColeta(CreateColetaEvent event, emit) async {
    emit(LoadingHome());

    final result = await createColetasUseCase(event.coleta);

    result.fold(
      (success) => emit(SuccessCreateColetaHome(coleta: success)),
      (failure) => emit(ErrorHome(message: failure.message)),
    );
  }
}
