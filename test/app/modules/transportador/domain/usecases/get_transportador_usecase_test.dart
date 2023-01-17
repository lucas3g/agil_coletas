import 'package:agil_coletas/app/modules/transportador/domain/entities/transportador.dart';
import 'package:agil_coletas/app/modules/transportador/domain/repositories/transportador_repository.dart';
import 'package:agil_coletas/app/modules/transportador/domain/usecases/get_transportador_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class ITransportadorRepositoryMock extends Mock
    implements ITransportadorRepository {}

void main() {
  late ITransportadorRepository repository;
  late IGetTransportadorUseCase getTransportadorUseCase;

  setUp(() {
    repository = ITransportadorRepositoryMock();
    getTransportadorUseCase = GetTransportadorUseCase(repository: repository);
  });

  test('deve retornar uma lista de transportadores', () async {
    when(
      () => repository.getTransportador(),
    ).thenAnswer((_) async => <Transportador>[].toSuccess());

    final result = await getTransportadorUseCase();

    expect(result.fold(id, id), isA<List<Transportador>>());
  });
}
