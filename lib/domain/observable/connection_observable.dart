import 'package:starwars/domain/observable/observable.dart';
import 'package:starwars/domain/observable/observer.dart';

/// Clase observable que notifica a sus observadores de un cambio
class ConnectionObservable implements Observable {
  /// Usar un factory es importante
  /// porque promete devolver un objeto de este tipo
  /// pero no promete hacer uno nuevo.
  factory ConnectionObservable() {
    return _instance;
  }

  /// Este constructor privado es el "real"
  /// Solo se llama una vez, por la asignación de la propiedad estática anterior
  /// también es privado, por lo que solo se puede llamar en esta clase
  ConnectionObservable._internal();

  static final ConnectionObservable _instance =
      ConnectionObservable._internal();

  final List<Observer> _observerList = [];

  /// Indica si hay conexión
  void changeConnectionStatus(bool newValue) {
    notifyObservers(newValue: newValue);
  }

  @override
  void addObserver(Observer observer) {
    _observerList.add(observer);
  }

  @override
  void removeObserver(Observer observer) {
    _observerList.remove(observer);
  }

  @override
  void notifyObservers({required bool newValue}) {
    for (final observer in _observerList) {
      observer.notifyChange(newValue: newValue);
    }
  }
}
