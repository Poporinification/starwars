import 'package:starwars/domain/observable/observer.dart';

/// Clase observable que notifica a sus observadores de un cambio
abstract class Observable {
  /// Agrega un observador al observable
  void addObserver(Observer observer);

  /// Elimina un observador del observable
  void removeObserver(Observer observer);

  /// Notifica a los observadores de un cambio
  void notifyObservers({required bool newValue}) {}
}
