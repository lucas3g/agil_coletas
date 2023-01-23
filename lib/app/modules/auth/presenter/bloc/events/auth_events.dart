import 'package:agil_coletas/app/modules/auth/domain/entities/user.dart';

abstract class AuthEvents {}

class SignInAuthEvent extends AuthEvents {
  final User user;

  SignInAuthEvent({
    required this.user,
  });
}

class SignOutUserEvent extends AuthEvents {}
