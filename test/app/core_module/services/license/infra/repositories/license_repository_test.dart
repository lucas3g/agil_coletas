import 'package:agil_coletas/app/core_module/services/license/domain/entities/license.dart';
import 'package:agil_coletas/app/core_module/services/license/infra/datasources/license_datasource.dart';
import 'package:agil_coletas/app/core_module/services/license/infra/repositories/license_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/functions.dart';

import '../../domain/usecases/verify_license_usecase_test.dart';

class ILicenseDatasourceMock extends Mock implements ILicenseDatasource {}

void main() {
  late ILicenseDatasource datasource;
  late LicenseRepository repository;

  setUp(() {
    datasource = ILicenseDatasourceMock();
    repository = LicenseRepository(datasource: datasource);
  });

  test('deve retornar uma instancia de License', () async {
    when(
      () => datasource.verifyLicense(device),
    ).thenAnswer((_) async => jsonLicense);

    final result = await repository.verifyLicense(device);

    expect(result.fold(id, id), isA<License>());
  });
}

final Map<String, dynamic> jsonLicense = {
  'ATIVO': 'S',
};
