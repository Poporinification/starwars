part of 'menu_cubit.dart';

/// Estado del menú
sealed class MenuState {}

/// Estado inicial del menú
final class MenuInitialState extends MenuState {}

/// Estado cargando el estado de conectividad almacenado
final class LoadingStoredConnectivityStatus extends MenuState {}

/// Estado cargado del estado de conectividad almacenado
final class StoredConnectivityStatusLoaded extends MenuState {
  /// Constructor del estado cargado del estado de conectividad almacenado
  StoredConnectivityStatusLoaded({
    required this.isConnected,
  });

  /// Indica si hay conexión
  final bool isConnected;
}

/// Estado error cargando el estado de conectividad almacenado
final class ErrorLoadingStoredConnectivityStatus extends MenuState {
  /// Constructor del estado error cargando el estado de conectividad almacenado
  ErrorLoadingStoredConnectivityStatus(this.message);

  /// Mensaje de error
  final String message;
}
