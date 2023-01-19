// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';

abstract class HomeStates {}

class InitialHome extends HomeStates {}

class LoadingHome extends HomeStates {}

class SuccessGetColetasHome extends HomeStates {
  final List<Coletas> coletas;

  SuccessGetColetasHome({
    required this.coletas,
  });
}

class SuccessCreateColetaHome extends HomeStates {
  final Coletas coleta;

  SuccessCreateColetaHome({
    required this.coleta,
  });
}

class SuccessUpdateColetaHome extends HomeStates {}

class SuccessSendColetaToServerHome extends HomeStates {}

class ErrorHome extends HomeStates {
  final String message;

  ErrorHome({
    required this.message,
  });
}
