import 'package:agil_coletas/app/core_module/constants/constants.dart';
import 'package:agil_coletas/app/core_module/services/client_http/client_http_interface.dart';
import 'package:agil_coletas/app/core_module/services/license/external/license_datasource.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/sqflite_storage_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks.dart';
import '../domain/usecases/verify_license_usecase_test.dart';
import '../infra/repositories/license_repository_test.dart';

void main() {
  late IClientHttp clientHttp;
  late ISQLFliteStorage storage;
  late LicenseDatasource datasource;

  setUp(() {
    clientHttp = IClientHttpMock();
    storage = IStorgeServiceMock();
    datasource = LicenseDatasource(clientHttp: clientHttp, storage: storage);
  });

  test('deve retornar uma instancia de Map', () async {
    when(
      () => clientHttp.get('$baseUrlLicense/licenca'),
    ).thenAnswer(
      (_) async => BaseResponse(
        jsonLicense,
        BaseRequest(url: '$baseUrlLicense/licenca', method: 'GET'),
      ),
    );

    final result = await datasource.verifyLicense(device);

    expect(result, isA<Map<String, dynamic>>());
  });
}
