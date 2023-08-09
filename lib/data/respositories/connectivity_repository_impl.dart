// ignore_for_file: inference_failure_on_function_invocation

import 'package:starwars/data/model/connecitivity_model.dart';
import 'package:starwars/domain/entities/connetivity.dart';
import 'package:starwars/domain/repositories/connectivity_repository.dart';
import 'package:starwars/domain/repositories/storage_repository.dart';

/// Clase que implementa el repositorio ConnectivityRepository
class ConnectivityRepositoryImpl implements ConnectivityRepository {
  /// Constructor de la clase
  ConnectivityRepositoryImpl({
    required this.storageRepository,
  });

  /// Instancia de almacenamiento
  final StorageRepository storageRepository;

  /// Nombre de la caja
  final String boxName = 'connectivity';

  @override
  Future<Connectivity> getConnectivityStatus() async {
    final result = await storageRepository.getBoxes(boxName);

    final connectivity =
        ConnectivityModel.fromJson(result[0] as Map<dynamic, dynamic>)
            .toEntity();

    return connectivity;
  }

  @override
  Future<void> saveConnectivityStatus(bool value) async {
    final connectivityModel = ConnectivityModel.fromJson({
      'hasConnection': value,
    });

    storageRepository.addBoxes(
      [connectivityModel.toJson()],
      boxName,
    );
  }

  @override
  Future<void> updateConnectivityStatus(bool value) async {
    final connectivityModel = ConnectivityModel.fromJson({
      'hasConnection': value,
    });

    storageRepository.putBox(
      boxName,
      connectivityModel.toJson(),
    );
  }

  @override
  Future<bool> hasStoredConnectivityStatus() async {
    return await storageRepository.isExists(boxName: boxName);
  }
}
