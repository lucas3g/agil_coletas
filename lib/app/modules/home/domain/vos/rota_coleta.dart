// ignore_for_file: public_member_api_docs, sort_constructors_first
class RotaColeta {
  final int _rota;
  final String _nome;

  int get rota => _rota;

  String get nome => _nome;

  RotaColeta({
    required rota,
    required nome,
  })  : _rota = rota,
        _nome = nome;
}
