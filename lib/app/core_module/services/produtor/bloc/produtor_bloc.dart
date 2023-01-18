// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:agil_coletas/app/core_module/services/produtor/bloc/events/produtor_events.dart';
import 'package:agil_coletas/app/core_module/services/produtor/bloc/states/produtor_states.dart';
import 'package:agil_coletas/app/core_module/services/produtor/domain/usecases/get_produtores_usecase.dart';
import 'package:agil_coletas/app/core_module/services/produtor/domain/usecases/save_produtores_usecase.dart';

class ProdutorBloc extends Bloc<ProdutorEvents, ProdutorStates> {
  final IGetProdutoresUseCase getProdutoresUseCase;
  final ISaveProdutoresUseCase saveProdutoresUseCase;

  ProdutorBloc({
    required this.getProdutoresUseCase,
    required this.saveProdutoresUseCase,
  }) : super(InitialProdutor()) {
    on<GetProdutoresEvent>(_getProdutor);
    on<SaveProdutoresEvent>(_saveProdutores);
  }

  Future _getProdutor(GetProdutoresEvent event, emit) async {
    emit(LoadingProdutor());

    final result = await getProdutoresUseCase();

    result.fold(
      (success) => emit(SuccessGetProdutor(produtores: success)),
      (failure) => emit(ErrorProdutor(message: failure.message)),
    );
  }

  Future _saveProdutores(SaveProdutoresEvent event, emit) async {
    emit(LoadingProdutor());

    final result = await saveProdutoresUseCase(event.produtores);

    result.fold(
      (success) => emit(SuccessSaveProdutor()),
      (failure) => emit(ErrorProdutor(message: failure.message)),
    );
  }
}
