import 'package:agil_coletas/app/core_module/constants/constants.dart';
import 'package:agil_coletas/app/core_module/services/client_http/client_http_interface.dart';
import 'package:agil_coletas/app/modules/auth/external/datasources/auth_datasource.dart';
import 'package:agil_coletas/app/modules/auth/infra/adapters/user_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../domain/usecases/signin_user_usecase_test.dart';

class IClientHttpMock extends Mock implements IClientHttp {}

void main() {
  late IClientHttp clientHttp;
  late AuthDatasource authDatasource;

  setUp(() {
    clientHttp = IClientHttpMock();
    authDatasource = AuthDatasource(clientHttp: clientHttp);
  });

  test('deve retornar um Map<String, dynamic> com os dados do funcionario',
      () async {
    when(() => clientHttp.post(
          '$baseUrl/login',
          data: UserAdapter.toJson(user),
        )).thenAnswer(
      (_) async => BaseResponse(
        jsonFuncionaro,
        BaseRequest(url: '$baseUrl/login', method: 'POST'),
      ),
    );

    final result = await authDatasource.signInUser(user);

    expect(result, isA<Map<String, dynamic>>());
  });
}

final Map<String, dynamic> jsonFuncionaro = {
  'id': 1,
  'nome': 'Lucas',
  'ccusto': 101,
  'empresa': 'EL Sistemas',
};
