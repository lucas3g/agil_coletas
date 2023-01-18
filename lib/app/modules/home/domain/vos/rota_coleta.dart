class RotaColeta {
  final int _codigo;
  final String _nome;

  int get codigo => _codigo;
  String get nome => _nome;

  RotaColeta({
    required codigo,
    required nome,
  })  : _codigo = codigo,
        _nome = nome;
}
