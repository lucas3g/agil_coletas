import 'package:agil_coletas/app/core_module/services/impressora_bluetooth/entity/impressoras.dart';
import 'package:agil_coletas/app/core_module/types/my_exception.dart';
import 'package:agil_coletas/app/modules/home/domain/entities/coletas.dart';
import 'package:agil_coletas/app/modules/tikets/domain/entities/tiket.dart';
import 'package:result_dart/result_dart.dart';

abstract class IBlueThermalPrinter {
  Future<Result<List<Impressoras>, IMyException>> getImpressoras();
  Future<Result<bool, IMyException>> connectDevice(Impressoras imp);
  Future<Result<bool, IMyException>> disconnectDevice(Impressoras imp);
  Future<Result<Unit, IMyException>> imprimirPaginaTeste();
  Future<Result<Unit, IMyException>> imprimirTiket(Tiket tiket);
  Future<Result<Unit, IMyException>> imprimirRotaFinalizada(Coletas coleta);
  Future<Result<bool, IMyException>> saveImpressoraLocalStorage(
    Impressoras imp,
  );
  Future<Result<bool, IMyException>> removeImpressoraLocalStorage();
  Result<Impressoras, IMyException> getImpressoraConectada();
}
