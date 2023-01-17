// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class RotasEvents {}

class GetRotasEvent extends RotasEvents {}

class FiltraRotasEvent extends RotasEvents {
  final String value;

  FiltraRotasEvent({
    required this.value,
  });
}
