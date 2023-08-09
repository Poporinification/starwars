/// Interfaz que define los métodos que deben implementar los observadores
abstract class Observer {
  /// Notifica un cambio en el observador
  void notifyChange({required bool newValue}) {}
}
