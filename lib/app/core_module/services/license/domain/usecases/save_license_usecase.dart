import 'package:result_dart/result_dart.dart';

import 'package:agil_coletas/app/core_module/services/license/domain/repositories/license_repository.dart';
import 'package:agil_coletas/app/core_module/types/my_exception.dart';

abstract class ISaveLicenseUseCase {
  Future<Result<bool, IMyException>> call();
}

class SaveLicenseUseCase implements ISaveLicenseUseCase {
  final ILicenseRepository repository;

  SaveLicenseUseCase({
    required this.repository,
  });

  @override
  Future<Result<bool, IMyException>> call() async {
    return await repository.saveLicense();
  }
}
