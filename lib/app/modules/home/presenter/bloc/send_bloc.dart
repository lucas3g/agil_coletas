// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/modules/home/presenter/bloc/events/send_events.dart';
import 'package:agil_coletas/app/modules/home/presenter/bloc/states/send_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:agil_coletas/app/modules/home/domain/usecases/send_coleta_to_server_usecase.dart';

class SendBloc extends Bloc<SendEvents, SendStates> {
  final ISendColetaToServerUseCase sendColetaToServerUseCase;

  SendBloc({
    required this.sendColetaToServerUseCase,
  }) : super(InititalSend()) {
    on<SendColetasToServerEvent>(_sendColetaToServer);
  }

  Future _sendColetaToServer(SendColetasToServerEvent event, emit) async {
    emit(LoadingSend());

    final result = await sendColetaToServerUseCase();

    await Future.delayed(const Duration(milliseconds: 400));

    result.fold(
      (success) {
        if (success) {
          return emit(SuccessSend());
        }

        return emit(AllColetasAlreadyBeenSent());
      },
      (failure) => emit(ErrorSend(message: failure.message)),
    );
  }
}
