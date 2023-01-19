// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/core_module/services/license/domain/repositories/license_repository.dart';
import 'package:result_dart/result_dart.dart';

import 'package:agil_coletas/app/core_module/types/my_exception.dart';

abstract class IGetDateLicenseUseCase {
  Future<Result<DateTime, IMyException>> call();
}

class GetDateLicenseUseCase implements IGetDateLicenseUseCase {
  final ILicenseRepository repository;

  GetDateLicenseUseCase({
    required this.repository,
  });

  @override
  Future<Result<DateTime, IMyException>> call() {
    return repository.getDateLicense();
  }
}
