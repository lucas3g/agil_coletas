// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/modules/tikets/domain/entities/tiket.dart';

abstract class TiketStates {}

class InitialTiket extends TiketStates {}

class LoadingTiket extends TiketStates {}

class SuccessSaveProdutoresTiket extends TiketStates {
  final bool save;

  SuccessSaveProdutoresTiket({
    required this.save,
  });
}

class SuccessCreateTiket extends TiketStates {
  final int codColeta;

  SuccessCreateTiket({
    required this.codColeta,
  });
}

class SuccessGetTikets extends TiketStates {
  final List<Tiket> tikets;

  SuccessGetTikets({
    required this.tikets,
  });
}

class ErrorTiket extends TiketStates {
  final String message;

  ErrorTiket({
    required this.message,
  });
}
