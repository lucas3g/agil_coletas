// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';

abstract class HomeEvents {}

class GetColetasEvent extends HomeEvents {}

class CreateColetaEvent extends HomeEvents {
  final Coletas coleta;

  CreateColetaEvent({
    required this.coleta,
  });
}

class UpdateColetaEvent extends HomeEvents {
  final Coletas coleta;

  UpdateColetaEvent({
    required this.coleta,
  });
}

class RemoveAllColetasEvent extends HomeEvents {}
