/// Interfaz que define los métodos que debe implementar un repositorio de
/// almacenamiento.
abstract class StorageRepository {
  /// Comprueba si existe una caja
  Future<bool> isExists({required String boxName});

  /// Añade una lista de elementos a una caja
  void addBoxes<T>(List<T> items, String boxName);

  /// Obtiene una lista de elementos de una caja
  Future<List<T>> getBoxes<T>(String boxName);

  /// Modifica un elemento de una caja
  void putBox<T>(String boxName, T item);
}
