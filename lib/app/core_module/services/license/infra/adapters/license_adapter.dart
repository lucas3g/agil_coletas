import 'package:agil_coletas/app/core_module/services/license/domain/entities/license.dart';
import 'package:agil_coletas/app/utils/formatters.dart';

class LicenseAdapter {
  static License fromMap(dynamic map) {
    return License(ativa: map['ATIVO'] ?? '');
  }

  static String toInsertSQL() {
    return "INSERT INTO LICENSE(DATA) VALUES ('${DateTime.now().AnoMesDiaDB()}')";
  }

  static String toUpdateSQL() {
    return "UPDATE LICENSE SET DATA = ? WHERE ID = ?";
  }
}
