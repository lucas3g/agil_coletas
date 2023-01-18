// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/modules/tikets/domain/entities/tiket.dart';
import 'package:agil_coletas/app/utils/formatters.dart';

abstract class TiketStates {
  final List<Tiket> tikets;
  final String filtro;

  TiketStates({
    required this.tikets,
    required this.filtro,
  });

  LoadingTiket loading() {
    return LoadingTiket(tikets: tikets, filtro: filtro);
  }

  SuccessCreateTiket successCreate(
    int codColeta,
  ) {
    return SuccessCreateTiket(
      codColeta: codColeta,
      tikets: tikets,
      filtro: filtro,
    );
  }

  SuccessGetTikets successGet({List<Tiket>? tikets, String? filtro}) {
    return SuccessGetTikets(
      tikets: tikets ?? this.tikets,
      filtro: filtro ?? this.filtro,
    );
  }

  SuccessUpdateTikets successUpdate() {
    return SuccessUpdateTikets(tikets: tikets, filtro: filtro);
  }

  ErrorTiket error(String message) {
    return ErrorTiket(message: message, tikets: tikets, filtro: filtro);
  }

  List<Tiket> get tiketsFiltrados {
    if (filtro.isEmpty) {
      return tikets;
    }

    return tikets
        .where((tiket) => (tiket.produtor.nome
            .toLowerCase()
            .removeAcentos()
            .contains(filtro.toLowerCase().removeAcentos())))
        .toList();
  }
}

class InitialTiket extends TiketStates {
  InitialTiket() : super(tikets: [], filtro: '');
}

class LoadingTiket extends TiketStates {
  LoadingTiket({required super.tikets, required super.filtro});
}

class SuccessSaveProdutoresTiket extends TiketStates {
  final bool save;

  SuccessSaveProdutoresTiket({
    required this.save,
    required super.tikets,
    required super.filtro,
  });
}

class SuccessCreateTiket extends TiketStates {
  final int codColeta;

  SuccessCreateTiket({
    required this.codColeta,
    required super.tikets,
    required super.filtro,
  });
}

class SuccessGetTikets extends TiketStates {
  SuccessGetTikets({
    required super.tikets,
    required super.filtro,
  });
}

class SuccessUpdateTikets extends TiketStates {
  SuccessUpdateTikets({required super.tikets, required super.filtro});
}

class ErrorTiket extends TiketStates {
  final String message;

  ErrorTiket({
    required this.message,
    required super.tikets,
    required super.filtro,
  });
}
