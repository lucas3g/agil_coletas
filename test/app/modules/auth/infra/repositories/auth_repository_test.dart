import 'package:agil_coletas/app/modules/auth/domain/entities/user.dart';
import 'package:agil_coletas/app/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:agil_coletas/app/modules/auth/infra/repositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/functions.dart';

import '../../domain/usecases/signin_user_usecase_test.dart';

class IAuthDatasourceMock extends Mock implements IAuthDatasource {}

void main() {
  late IAuthDatasource datasource;
  late AuthRepository repository;

  setUp(() {
    datasource = IAuthDatasourceMock();
    repository = AuthRepository(datasource: datasource);
  });

  test('deve retornar uma instancia de user', () async {
    when(
      () => datasource.signInUser(user),
    ).thenAnswer((_) async => json);

    final result = await repository.signinUser(user);

    expect(result.fold(id, id), isA<User>());
  });
}

final json = {
  'id': '1',
  'nome': 'lucas',
  'cnpj': '97.305.890/0001-81',
  'login': 'adm',
  'password': 'pass'
};
