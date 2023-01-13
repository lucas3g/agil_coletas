import 'package:agil_coletas/app/core_module/services/device_info/device_info_interface.dart';
import 'package:agil_coletas/app/core_module/services/license/domain/entities/license.dart';
import 'package:agil_coletas/app/core_module/services/license/domain/repositories/license_repository.dart';
import 'package:agil_coletas/app/core_module/services/license/domain/usecases/verify_license_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class ILicenseRepositoryMock extends Mock implements ILicenseRepository {}

void main() {
  late ILicenseRepository repository;
  late VerifyLicenseUseCase verifyLicenseUseCase;

  setUp(() {
    repository = ILicenseRepositoryMock();
    verifyLicenseUseCase = VerifyLicenseUseCase(repository: repository);
  });

  test('deve retornar uma instancia de License', () async {
    when(
      () => repository.verifyLicense(device),
    ).thenAnswer((_) async => license.toSuccess());

    final result = await verifyLicenseUseCase(device);

    expect(result.fold(id, id), isA<License>());
  });
}

final device = DeviceInfo(deviceID: 'deviceID');

final license = License(ativa: 'S');
