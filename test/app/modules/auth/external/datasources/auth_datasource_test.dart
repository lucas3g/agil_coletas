import 'package:agil_coletas/app/core_module/constants/constants.dart';
import 'package:agil_coletas/app/core_module/services/client_http/client_http_interface.dart';
import 'package:agil_coletas/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:agil_coletas/app/modules/auth/external/datasources/auth_datasource.dart';
import 'package:agil_coletas/app/modules/auth/infra/adapters/user_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks.dart';
import '../../domain/usecases/signin_user_usecase_test.dart';

void main() {
  late IClientHttp clientHttp;
  late ILocalStorage localStorage;
  late AuthDatasource authDatasource;

  setUp(() {
    clientHttp = IClientHttpMock();
    localStorage = ILocalStorageMock();
    authDatasource =
        AuthDatasource(clientHttp: clientHttp, localStorage: localStorage);
  });

  test('deve retornar um Map<String, dynamic> com os dados do funcionario',
      () async {
    when(() => clientHttp.post(
          '$baseUrl/login',
          data: UserAdapter.toJson(user),
        )).thenAnswer(
      (_) async => BaseResponse(
        jsonFuncionaro,
        BaseRequest(
          url: '$baseUrl/login',
          method: 'POST',
          data: UserAdapter.toJson(user),
        ),
      ),
    );

    final result = await authDatasource.signInUser(user);

    expect(result, isA<Map<String, dynamic>>());
  });
}

final Map<String, dynamic> jsonFuncionaro = {
  'ID': 1,
  'NOME': 'Lucas',
  'CCUSTO': 101,
  'DESC_EMPRESA': 'EL Sistemas',
};
