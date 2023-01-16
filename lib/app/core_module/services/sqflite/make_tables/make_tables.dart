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
      const TableFieldEntity(name: 'CLIFOR', type: FieldType.integer),
      const TableFieldEntity(name: 'UF', type: FieldType.string),
      const TableFieldEntity(name: 'MUNICIPIO', type: FieldType.string),
      const TableFieldEntity(name: 'NOME', type: FieldType.string),
      const TableFieldEntity(name: 'PRODUTO', type: FieldType.integer),
      const TableFieldEntity(name: 'DATA', type: FieldType.string),
      const TableFieldEntity(name: 'TIKET', type: FieldType.integer),
      const TableFieldEntity(name: 'QUANTIDADE', type: FieldType.integer),
      const TableFieldEntity(name: 'PER_DESCONTO', type: FieldType.real),
      const TableFieldEntity(name: 'CCUSTO', type: FieldType.integer),
      const TableFieldEntity(name: 'ROTA_COLETA', type: FieldType.integer),
      const TableFieldEntity(name: 'CRIOSCOPIA', type: FieldType.real),
      const TableFieldEntity(name: 'ALIZAROL', type: FieldType.integer),
      const TableFieldEntity(name: 'HORA', type: FieldType.string),
      const TableFieldEntity(name: 'PARTICAO', type: FieldType.integer),
      const TableFieldEntity(name: 'OBSERVACAO', type: FieldType.string),
      const TableFieldEntity(name: 'PLACA', type: FieldType.string),
      const TableFieldEntity(name: 'TEMPERATURA', type: FieldType.real),
      const TableFieldEntity(
          name: 'QTD_VEZES_EDITADO', type: FieldType.integer),
    };

    final table = TableEntity(name: 'TIKETS', fields: fields);

    return table;
  }

  static TableEntity license() {
    final fields = {
      const TableFieldEntity(name: 'DATA', type: FieldType.string),
    };

    final table = TableEntity(name: 'LICENSE', fields: fields);

    return table;
  }

  static TableEntity rotas() {
    final fields = {
      const TableFieldEntity(name: 'ID', type: FieldType.integer, pk: true),
      const TableFieldEntity(name: 'DESCRICAO', type: FieldType.string),
      const TableFieldEntity(name: 'TRANSPORTADOR', type: FieldType.string),
      const TableFieldEntity(name: 'ROTA_FINALIZADA', type: FieldType.integer),
    };

    final table = TableEntity(name: 'ROTAS', fields: fields);

    return table;
  }

  static TableEntity caminhoes() {
    final fields = {
      const TableFieldEntity(name: 'PLACA', type: FieldType.string),
      const TableFieldEntity(name: 'DESCRICAO', type: FieldType.string),
      const TableFieldEntity(name: 'TANQUES', type: FieldType.integer),
    };

    final table = TableEntity(name: 'CAMINHOES', fields: fields);

    return table;
  }

  static TableEntity produtores() {
    final fields = {
      const TableFieldEntity(name: 'ID', type: FieldType.integer, pk: true),
      const TableFieldEntity(name: 'CLIFOR', type: FieldType.integer),
      const TableFieldEntity(name: 'ROTA', type: FieldType.integer),
      const TableFieldEntity(name: 'NOME', type: FieldType.string),
      const TableFieldEntity(name: 'MUNICIPIO', type: FieldType.string),
      const TableFieldEntity(name: 'UF', type: FieldType.string),
    };

    final table = TableEntity(name: 'PRODUTORES', fields: fields);

    return table;
  }
}
