import 'package:agil_coletas/app/core_module/services/license/domain/entities/license.dart';

class LicenseAdapter {
  static License fromMap(dynamic map) {
    return License(ativa: map['ATIVO'] ?? '');
  }
}
