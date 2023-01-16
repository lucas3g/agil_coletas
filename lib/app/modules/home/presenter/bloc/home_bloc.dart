// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:agil_coletas/app/modules/home/domain/usecases/get_coletas_usecase.dart';
import 'package:agil_coletas/app/modules/home/presenter/bloc/events/home_events.dart';
import 'package:agil_coletas/app/modules/home/presenter/bloc/states/home_states.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  final IGetColetasUseCase getColetasUseCase;

  HomeBloc({
    required this.getColetasUseCase,
  }) : super(InitialHome()) {
    on<GetColetasEvent>(_getColetas);
  }

  Future _getColetas(GetColetasEvent event, emit) async {
    emit(LoadingHome());

    final result = await getColetasUseCase();

    result.fold(
      (success) => emit(SuccessGetColetasHome(coletas: success)),
      (failure) => emit(ErrorHome(message: failure.message)),
    );
  }
}
