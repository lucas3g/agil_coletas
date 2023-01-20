import 'package:agil_coletas/app/core_module/services/baixa_tudo/baixa_tudo.dart';
import 'package:agil_coletas/app/core_module/services/produtor/bloc/produtor_bloc.dart';
import 'package:agil_coletas/app/modules/rotas/presenter/bloc/rotas_bloc.dart';
import 'package:agil_coletas/app/modules/transportador/presenter/bloc/transportador_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BaixaTudoController {
  final baixaTudo = BaixaTudo(
      rotasBloc: Modular.get<RotasBloc>(),
      produtorBloc: Modular.get<ProdutorBloc>(),
      transportadorBloc: Modular.get<TransportadorBloc>());

  BaixaTudoController._();

  static BaixaTudoController get instance => BaixaTudoController._();
}
