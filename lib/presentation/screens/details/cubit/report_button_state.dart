part of 'report_button_cubit.dart';

/// Estado del botón para reportar personaje
sealed class ReportButtonState {}

/// Estado inicial del botón para reportar personaje
final class ReportButtonInitialState extends ReportButtonState {}

/// Estado reportando personaje
final class ReportingCharacter extends ReportButtonState {}

/// Estado personaje reportado
final class CharacterReported extends ReportButtonState {}

/// Estado error reportando personaje
final class ErrorReportingCharacter extends ReportButtonState {
  /// Constructor del estado error reportando personaje
  ErrorReportingCharacter(this.message);

  /// Mensaje de error
  final String message;
}

/// Estado cargando el estado de conectividad
final class LoadingConnectivityStatus extends ReportButtonState {}

/// Estado cargado del estado de conectividad
final class ConnectivityStatusLoaded extends ReportButtonState {
  /// Constructor del estado cargado del estado de conectividad
  ConnectivityStatusLoaded({required this.connectivity});

  /// Estado de conectividad
  final Connectivity connectivity;
}

/// Estado error cargando el estado de conectividad
final class ErrorGettingConnectivityStatus extends ReportButtonState {
  /// Constructor del estado error cargando el estado de conectividad
  ErrorGettingConnectivityStatus(this.message);

  /// Mensaje de error
  final String message;
}
