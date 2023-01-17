// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/modules/rotas/domain/entities/rotas.dart';
import 'package:agil_coletas/app/utils/formatters.dart';

abstract class RotasStates {
  final List<Rotas> rotas;
  final String filtro;

  RotasStates({
    required this.rotas,
    required this.filtro,
  });

  SuccessGetRotas succcess({List<Rotas>? rotas, String? filtro}) {
    return SuccessGetRotas(
      rotas: rotas ?? this.rotas,
      filtro: filtro ?? this.filtro,
    );
  }

  LoadingRotas loading() {
    return LoadingRotas(rotas: rotas, filtro: filtro);
  }

  ErrorRotas error(String message) {
    return ErrorRotas(message: message, rotas: rotas, filtro: filtro);
  }

  List<Rotas> get rotasFiltradas {
    if (filtro.isEmpty) {
      return rotas;
    }

    return rotas
        .where((rota) => (rota.descricao
            .toLowerCase()
            .removeAcentos()
            .contains(filtro.toLowerCase().removeAcentos())))
        .toList();
  }
}

class InitialRotas extends RotasStates {
  InitialRotas() : super(rotas: [], filtro: '');
}

class LoadingRotas extends RotasStates {
  LoadingRotas({required super.rotas, required super.filtro});
}

class SuccessGetRotas extends RotasStates {
  SuccessGetRotas({required super.rotas, required super.filtro});
}

class ErrorRotas extends RotasStates {
  final String message;

  ErrorRotas({
    required this.message,
    required super.rotas,
    required super.filtro,
  });
}
