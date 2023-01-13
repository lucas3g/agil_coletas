// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agil_coletas/app/core_module/constants/constants.dart';
import 'package:agil_coletas/app/core_module/services/client_http/client_http_interface.dart';
import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/auth/domain/entities/user.dart';
import 'package:agil_coletas/app/modules/auth/infra/adapters/user_adapter.dart';
import 'package:agil_coletas/app/modules/auth/infra/datasources/auth_datasource.dart';

class AuthDatasource implements IAuthDatasource {
  final IClientHttp clientHttp;

  AuthDatasource({
    required this.clientHttp,
  });

  @override
  Future<Map<String, dynamic>> signInUser(User user) async {
    final response = await clientHttp.post(
      '$baseUrl/login',
      data: UserAdapter.toJson(user),
    );

    if (response.data['erro'] != null) {
      throw MyException(message: response.data['erro']);
    }

    if (response.statusCode != 200) {
      throw const MyException(
          message: 'Não foi possivel comunicar-se com o servidor.');
    }

    return response.data;
  }
}
