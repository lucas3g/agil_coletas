import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';
import 'package:agil_coletas/app/modules/home/infra/datasources/home_datasource.dart';
import 'package:agil_coletas/app/modules/home/infra/repositories/home_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/functions.dart';

class IHomeDatasourceMock extends Mock implements IHomeDatasource {}

void main() {
  late IHomeDatasource datasource;
  late HomeRepository repository;

  setUp(() {
    datasource = IHomeDatasourceMock();
    repository = HomeRepository(datasource: datasource);
  });

  test('deve retornar uma lista de coletas', () async {
    when(
      () => datasource.getColetas(),
    ).thenAnswer((_) async => <Coletas>[]);

    final result = await repository.getColetas();

    expect(result.fold(id, id), isA<List<Coletas>>());
  });
}
