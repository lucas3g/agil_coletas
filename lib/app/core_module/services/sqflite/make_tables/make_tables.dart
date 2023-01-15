import 'package:agil_coletas/app/core_module/services/sqflite/adapters/table_entity.dart';

class MakeTables {
  static TableEntity coletas() {
    final fields = {
      const TableFieldEntity(name: 'ID', type: FieldType.integer, pk: true),
      const TableFieldEntity(name: 'COD_ROTA', type: FieldType.integer),
      const TableFieldEntity(name: 'NOME_ROTA', type: FieldType.string),
      const TableFieldEntity(name: 'DATA_MOV', type: FieldType.string),
      const TableFieldEntity(name: 'DT_HORA_INI', type: FieldType.string),
      const TableFieldEntity(name: 'DT_HORA_FIM', type: FieldType.string),
      const TableFieldEntity(name: 'MOTORISTA', type: FieldType.string),
      const TableFieldEntity(name: 'KM_INI', type: FieldType.integer),
      const TableFieldEntity(name: 'KM_FIM', type: FieldType.integer),
      const TableFieldEntity(name: 'CCUSTO', type: FieldType.integer),
      const TableFieldEntity(name: 'PLACA', type: FieldType.string),
      const TableFieldEntity(name: 'FINALIZADA', type: FieldType.integer),
      const TableFieldEntity(name: 'ENVIADA', type: FieldType.integer),
      const TableFieldEntity(name: 'TOTAL_COLETADO', type: FieldType.integer),
    };

    final table = TableEntity(name: 'COLETAS', fields: fields);

    return table;
  }

  static TableEntity tiket() {
    final fields = {
      const TableFieldEntity(name: 'ID', type: FieldType.integer, pk: true),
      const TableFieldEntity(name: 'ID_COLETA', type: FieldType.integer),
      const TableFieldEntity(name: 'CLIFOR', type: FieldType.string),
      const TableFieldEntity(name: 'UF', type: FieldType.string),
      const TableFieldEntity(name: 'MUNICIPIO', type: FieldType.string),
      const TableFieldEntity(name: 'NOME_PRODUTOR', type: FieldType.string),
      const TableFieldEntity(name: 'PRODUTO', type: FieldType.string),
      const TableFieldEntity(name: 'DATA', type: FieldType.integer),
      const TableFieldEntity(name: 'KM_FIM', type: FieldType.integer),
      const TableFieldEntity(name: 'CCUSTO', type: FieldType.integer),
      const TableFieldEntity(name: 'PLACA', type: FieldType.string),
      const TableFieldEntity(name: 'FINALIZADA', type: FieldType.integer),
      const TableFieldEntity(name: 'ENVIADA', type: FieldType.integer),
      const TableFieldEntity(name: 'TOTAL_COLETADO', type: FieldType.integer),
    };

    final table = TableEntity(name: 'COLETAS', fields: fields);

    return table;
  }
}
