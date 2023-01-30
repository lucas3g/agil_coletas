// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/core_module/services/produtor/domain/entities/produtor.dart';

abstract class ProdutorEvents {}

class GetProdutoresEvent extends ProdutorEvents {}

class SaveProdutoresEvent extends ProdutorEvents {
  final List<Produtor> produtores;

  SaveProdutoresEvent({
    required this.produtores,
  });
}

class RemoveAllProdutores extends ProdutorEvents {}
