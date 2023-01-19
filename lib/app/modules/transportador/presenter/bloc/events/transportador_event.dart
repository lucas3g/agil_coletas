// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/modules/transportador/domain/entities/transportador.dart';

abstract class TransportadorEvents {}

class GetTransportadorEvent extends TransportadorEvents {}

class FiltraTransportadorEvent extends TransportadorEvents {
  final String value;

  FiltraTransportadorEvent({
    required this.value,
  });
}

class SaveTransportadorEvent extends TransportadorEvents {
  final List<Transportador> transportadores;

  SaveTransportadorEvent({
    required this.transportadores,
  });
}
