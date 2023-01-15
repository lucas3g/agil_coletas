import 'package:agil_coletas/app/core_module/vos/id_vo.dart';
import 'package:agil_coletas/app/modules/auth/domain/entities/funcionario.dart';
import 'package:agil_coletas/app/modules/auth/domain/entities/user.dart';
import 'package:agil_coletas/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:agil_coletas/app/modules/auth/domain/usecases/signin_user_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class AuthRepositoryMock extends Mock implements IAuthRepository {}

void main() {
  late IAuthRepository repository;
  late SignInUserUseCase useCase;

  setUp(() {
    repository = AuthRepositoryMock();
    useCase = SignInUserUseCase(repository: repository);
  });

  test('deve retorna uma instancia de funcionario', () async {
    when(() => repository.signinUser(user))
        .thenAnswer((_) async => funcionario.toSuccess());

    final result = await useCase(user);

    expect(result.fold(id, id), isA<Funcionario>());
  });
}

final User user = User(
    id: const IdVO(1),
    cnpj: '97.305.890/0001-81',
    login: 'ADM',
    password: 'EL');

final Funcionario funcionario = Funcionario(
    id: const IdVO(1), name: 'lucas', ccusto: 101, empresa: 'el sistemas');
