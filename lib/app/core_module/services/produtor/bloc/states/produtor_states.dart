import 'package:agil_coletas/app/core_module/services/produtor/domain/entities/produtor.dart';

abstract class ProdutorStates {}

class InitialProdutor extends ProdutorStates {}

class LoadingProdutor extends ProdutorStates {}

class SuccessGetProdutor extends ProdutorStates {
  final List<Produtor> produtores;

  SuccessGetProdutor({
    required this.produtores,
  });
}

class SuccessSaveProdutor extends ProdutorStates {}

class ErrorProdutor extends ProdutorStates {
  final String message;

  ErrorProdutor({
    required this.message,
  });
}
