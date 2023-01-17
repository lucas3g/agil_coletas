// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class TransportadorEvents {}

class GetTransportadorEvent extends TransportadorEvents {}

class FiltraTransportadorEvent extends TransportadorEvents {
  final String value;

  FiltraTransportadorEvent({
    required this.value,
  });
}
