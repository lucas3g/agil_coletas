abstract class TiketEvents {}

class GetProdutoresEvent extends TiketEvents {
  final int codRota;

  GetProdutoresEvent({
    required this.codRota,
  });
}

class CreateTiketsEvent extends TiketEvents {
  final int codRota;

  CreateTiketsEvent({
    required this.codRota,
  });
}

class GetTiketsEvent extends TiketEvents {
  final int codColeta;

  GetTiketsEvent({
    required this.codColeta,
  });
}
