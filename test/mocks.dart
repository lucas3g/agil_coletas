import 'package:agil_coletas/app/core_module/services/client_http/client_http_interface.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/sqflite_storage_interface.dart';
import 'package:mocktail/mocktail.dart';

class IClientHttpMock extends Mock implements IClientHttp {}

class IStorgeServiceMock extends Mock implements ISQLFliteStorage {}
