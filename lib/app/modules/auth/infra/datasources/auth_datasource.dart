import 'package:agil_coletas/app/modules/auth/domain/entities/user.dart';

abstract class IAuthDatasource {
  Future<String> signInUser(User user);
  Future<bool> signOutUser();
}
