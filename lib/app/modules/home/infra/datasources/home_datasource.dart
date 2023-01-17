import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';

abstract class IHomeDatasource {
  Future<List> getColetas();
  Future<Map<String, dynamic>> createColeta(Coletas coleta);
}
