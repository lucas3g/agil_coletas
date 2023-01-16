import 'package:agil_coletas/app/modules/rotas/domain/entities/rotas.dart';
import 'package:agil_coletas/app/modules/rotas/domain/repositories/rotas_repository.dart';
import 'package:agil_coletas/app/modules/rotas/domain/usecases/get_rotas_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class IRotasRepositoryMock extends Mock implements IRotasRepository {}

void main() {
  late IRotasRepository repository;
  late IGetRotasUseCase getRotasUseCase;

  setUp(() {
    repository = IRotasRepositoryMock();
    getRotasUseCase = GetRotasUseCase(repository: repository);
  });

  test('deve retornar uma lista de rotas', () async {
    when(
      () => repository.getRotas(),
    ).thenAnswer((_) async => <Rotas>[].toSuccess());

    final result = await getRotasUseCase();

    expect(result.fold(id, id), isA<List<Rotas>>());
  });
}
