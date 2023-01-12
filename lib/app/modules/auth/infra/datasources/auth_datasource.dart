import 'package:agil_coletas/app/modules/auth/domain/entities/user.dart';

abstract class IAuthDatasource {
  Future<Map<String, dynamic>> signInUser(User user);
}
