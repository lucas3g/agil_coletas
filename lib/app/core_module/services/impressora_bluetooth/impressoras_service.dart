// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:agil_coletas/app/core_module/services/sqflite/adapters/filter_entity.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/sqflite_adapter.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/adapters/tables.dart';
import 'package:agil_coletas/app/modules/tikets/infra/adapters/tiket_adapter.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:result_dart/result_dart.dart';

import 'package:agil_coletas/app/core_module/constants/constants.dart';
import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/blue_thermal_printer.dart';
import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/entity/impressoras.dart';
import 'package:agil_coletas/app/core_module/services/shared_preferences/adapters/shared_params.dart';
import 'package:agil_coletas/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:agil_coletas/app/core_module/services/sqflite/sqflite_storage_interface.dart';
import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';
import 'package:agil_coletas/app/modules/tikets/domain/entities/tiket.dart';
import 'package:agil_coletas/app/utils/formatters.dart';

class ImpressorasService implements IBlueThermalPrinter {
  final BlueThermalPrinter printer;
  final ILocalStorage localStorage;
  final ISQLFliteStorage storage;

  ImpressorasService({
    required this.printer,
    required this.localStorage,
    required this.storage,
  });

  @override
  Future<Result<List<Impressoras>, IMyException>> getImpressoras() async {
    try {
      final result = await printer.getBondedDevices();

      return result.map(Impressoras.fromDevice).toList().toSuccess();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<bool, IMyException>> connectDevice(Impressoras imp) async {
    try {
      await printer.connect(Impressoras.toDevice(imp));

      imp.setConnected(true);

      return true.toSuccess();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<bool, IMyException>> disconnectDevice(Impressoras imp) async {
    try {
      await printer.disconnect();

      imp.setConnected(false);

      return true.toSuccess();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<Unit, IMyException>> imprimirPaginaTeste() async {
    printer.printNewLine();
    printer.printCustom("Sucesso voce configurou a impressora!!", 1, 1);
    printer.printNewLine();
    printer.printNewLine();
    printer.printNewLine();
    printer.printNewLine();
    printer.printNewLine();
    printer.printNewLine();

    return unit.toSuccess();
  }

  @override
  Future<Result<bool, IMyException>> saveImpressoraLocalStorage(
      Impressoras imp) async {
    try {
      final result = await localStorage.setData(
        params: SharedParams(
          key: 'imp',
          value: Impressoras.toJson(imp),
        ),
      );

      return result.toSuccess();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<bool, IMyException>> removeImpressoraLocalStorage() async {
    try {
      final result = await localStorage.removeData('imp');

      return result.toSuccess();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }

  @override
  Result<Impressoras, IMyException> getImpressoraConectada() {
    try {
      final result =
          Impressoras.fromMap(jsonDecode(localStorage.getData('imp')));

      return result.toSuccess();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<Unit, IMyException>> imprimirRotaFinalizada(
      Coletas coleta) async {
    try {
      final filter = FilterEntity(
        name: 'ID_COLETA',
        value: coleta.id,
        type: FilterType.equal,
        operator: FilterOperator.and,
      );

      final param = SQLFliteGetPerFilterParam(
          table: Tables.tikets, columns: [], filters: {filter});

      final result = await storage.getPerFilter(param);

      final List<Tiket> tikets = [];

      for (var tiket in result) {
        tikets.add(TiketAdapter.fromMap(tiket));
      }

      late String descEmpresa =
          GlobalFuncionario.instance.funcionario.empresa.nome;

      descEmpresa = descEmpresa
          .substring(0, descEmpresa.length > 21 ? 21 : descEmpresa.length)
          .removeAcentos();

      printer.printCustom(
        descEmpresa,
        1,
        1,
      );

      printer.printNewLine();

      printer.printCustom(
          '${coleta.dataMov.toString().replaceAll('"', '')} / ${coleta.motorista}',
          1,
          1);

      printer.printNewLine();

      printer.printCustom('..:Resumo das Coletas:..', 1, 1);

      printer.printNewLine();
      for (var item in tikets) {
        printer.printCustom(
            'Produtor: ${item.produtor.nome.toString().substring(0, item.produtor.nome.toString().length > 20 ? 17 : item.produtor.nome.toString().length).removeAcentos()}',
            1,
            0);
        printer.printCustom('Qtd: ${item.quantidade.value}', 1, 0);
      }

      printer.printCustom('-------------------------------', 1, 0);

      final totalColetado = tikets.fold(
          0, (previousValue, e) => previousValue + e.quantidade.value);

      printer.printCustom('Total: $totalColetado', 1, 0);

      printer.printNewLine();
      printer.printNewLine();
      printer.printNewLine();
      printer.printNewLine();
      printer.printNewLine();

      return unit.toSuccess();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<Unit, IMyException>> imprimirTiket(Tiket tiket) async {
    try {
      late String descEmpresa =
          GlobalFuncionario.instance.funcionario.empresa.nome;

      descEmpresa = descEmpresa
          .substring(0, descEmpresa.length > 21 ? 21 : descEmpresa.length)
          .removeAcentos();

      printer.printCustom(
        descEmpresa,
        1,
        1,
      );
      printer.printNewLine();
      printer.printCustom(
          'Data: ${tiket.data.toString().replaceAll('"', '').replaceAll('.', '/')} Hora: ${tiket.hora.toString().replaceAll('"', '')}',
          1,
          0);
      printer.printCustom('Produtor: ${tiket.produtor.nome.trim()}', 1, 0);
      printer.printCustom(
          'Quant.: ${tiket.quantidade.value} Temperatura: ${tiket.temperatura.value}',
          1,
          0);
      printer.printCustom(
          'Alizarol: ${tiket.alizarol ? 'Positivo' : 'Negativo'}', 1, 0);
      printer.printCustom('Tanque: ${tiket.particao}', 1, 0);
      printer.printCustom('Placa: ${tiket.placa}', 1, 0);
      if (tiket.observacao.toString().trim().isNotEmpty) {
        printer.printCustom(
            'Motivo da Nao Coleta: ${tiket.observacao.toString().removeAcentos().trim()}',
            1,
            0);
      }
      printer.printNewLine();
      printer.printNewLine();
      printer.printNewLine();
      printer.printNewLine();
      printer.printCustom('________________________________', 1, 0);
      printer.printCustom(
          GlobalFuncionario.instance.funcionario.name.value, 1, 0);
      printer.printNewLine();
      printer.printNewLine();
      printer.printNewLine();
      printer.printNewLine();

      return unit.toSuccess();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }

  @override
  Future<Result<bool, IMyException>> verificaStatusImpressora() async {
    try {
      final result = await printer.isConnected ?? false;

      return result.toSuccess();
    } catch (e) {
      return MyException(message: e.toString()).toFailure();
    }
  }
}
