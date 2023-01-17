import 'dart:convert';

import 'package:agil_coletas/app/modules/transportador/domain/entities/transportador.dart';
import 'package:agil_coletas/app/modules/transportador/infra/datasources/transportador_datasouce.dart';
import 'package:agil_coletas/app/modules/transportador/infra/repositories/transportador_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/functions.dart';

class ITransportadorDatasourceMock extends Mock
    implements ITransportadorDatasource {}

void main() {
  late ITransportadorDatasource datasource;
  late TransportadorRepository repository;

  setUp(() {
    datasource = ITransportadorDatasourceMock();
    repository = TransportadorRepository(datasource: datasource);
  });

  test('deve retornar uma lista de transportador', () async {
    when(
      () => datasource.getTransportadorOnline(),
    ).thenAnswer((_) async => json);

    final result = await repository.getTransportador();

    expect(result.fold(id, id), isA<List<Transportador>>());
  });
}

final String json = jsonEncode([
  {
    'PLACA': 'ASDVF2',
    'DESCRICAO': 'LUCAS',
    'PARTICOES': 3,
  },
  {
    'PLACA': 'DFGDF3',
    'DESCRICAO': 'ENIO',
    'PARTICOES': 4,
  },
]);
