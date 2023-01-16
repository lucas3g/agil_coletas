class FunEmpresa {
  String _cnpj;
  String _nome;

  String get cnpj => _cnpj;
  void setCnpj(String value) => _cnpj = value;

  String get nome => _nome;
  void setNome(String value) => _nome = value;

  FunEmpresa({
    required String cnpj,
    required String nome,
  })  : _cnpj = cnpj,
        _nome = nome;
}
