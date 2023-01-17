import 'package:result_dart/result_dart.dart';

class KMColeta {
  int _inicial;
  int _ffinal;

  int get inical => _inicial;
  void setInicial(int value) => _inicial = value;

  int get ffinal => _ffinal;
  void setFinal(int value) => _ffinal = value;

  KMColeta({
    required inicial,
    required ffinal,
  })  : _inicial = inicial,
        _ffinal = ffinal;

  Result<KMColeta, String> validate([Object? object]) {
    if (inical <= 0) {
      return 'KM Inicial não pode ser menor ou igual a 0'.toFailure();
    }

    return Success(this);
  }
}
