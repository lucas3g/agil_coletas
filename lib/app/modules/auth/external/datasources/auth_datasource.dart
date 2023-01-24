// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/core_module/constants/constants.dart';
import 'package:agil_coletas/app/core_module/services/client_http/client_http_interface.dart';
import 'package:agil_coletas/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/auth/domain/entities/user.dart';
import 'package:agil_coletas/app/modules/auth/infra/adapters/user_adapter.dart';
import 'package:agil_coletas/app/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:brasil_fields/brasil_fields.dart';

class AuthDatasource implements IAuthDatasource {
  final IClientHttp clientHttp;
  final ILocalStorage localStorage;

  AuthDatasource({
    required this.clientHttp,
    required this.localStorage,
  });

  @override
  Future<String> signInUser(User user) async {
    final cnpj =
        UtilBrasilFields.removeCaracteres(user.cnpj.value).substring(0, 8);

    final response = await clientHttp.post(
      '$baseUrl/login2/$cnpj',
      data: UserAdapter.toJson(user),
    );

    await Future.delayed(const Duration(milliseconds: 500));

    if (response.data.toString().trim() == '') {
      throw const MyException(message: 'Usuário ou Senha incorretos.');
    }

    if (response.statusCode != 200) {
      throw const MyException(
          message: 'Não foi possivel comunicar-se com o servidor.');
    }

    return response.data;
  }

  @override
  Future<bool> signOutUser() async {
    return await localStorage.removeData('funcionario');
  }
}
