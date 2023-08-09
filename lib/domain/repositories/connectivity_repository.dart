import 'package:starwars/domain/entities/connetivity.dart';

/// Interfaz que define los métodos que deben implementar los repositorios de
/// conectividad
abstract class ConnectivityRepository {
  /// Obtiene el estado de la conexión
  Future<Connectivity> getConnectivityStatus();

  /// Guarda el estado de la conexión
  Future<void> saveConnectivityStatus(bool value);

  /// Actualiza el estado de la conexión
  Future<void> updateConnectivityStatus(bool value);

  /// Verifica si existe el estado de la conexión almacenado
  Future<bool> hasStoredConnectivityStatus();
}
