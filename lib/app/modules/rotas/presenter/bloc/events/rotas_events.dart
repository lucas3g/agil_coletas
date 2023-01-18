// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/modules/rotas/domain/entities/rotas.dart';

abstract class RotasEvents {}

class GetRotasEvent extends RotasEvents {}

class FiltraRotasEvent extends RotasEvents {
  final String value;

  FiltraRotasEvent({
    required this.value,
  });
}

class SaveRotasEvent extends RotasEvents {
  final List<Rotas> rotas;

  SaveRotasEvent({
    required this.rotas,
  });
}
