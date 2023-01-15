import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';
import 'package:agil_coletas/app/modules/home/domain/repositories/home_repository.dart';
import 'package:agil_coletas/app/modules/home/domain/usecases/get_coletas_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class IHomeRepositoryMock extends Mock implements IHomeRepository {}

void main() {
  late IHomeRepository repository;
  late GetColetasUseCase getColetasUseCase;

  setUp(() {
    repository = IHomeRepositoryMock();
    getColetasUseCase = GetColetasUseCase(repository: repository);
  });

  test('deve retornar uma lista de coletas', () async {
    when(
      () => repository.getColetas(),
    ).thenAnswer((_) async => <Coletas>[].toSuccess());

    final result = await getColetasUseCase();

    expect(result.fold(id, id), isA<List<Coletas>>());
  });
}
