part of 'character_details_cubit.dart';

/// Clase sellada que representa el estado de la pantalla de detalle de personaje
sealed class CharacterDetailsState {}

/// Estado inicial de la pantalla de detalle de personaje
final class CharacterDetailsInitialState extends CharacterDetailsState {}

/// Estado cargando el detalle de personaje
final class LoadingCharacterDetails extends CharacterDetailsState {}

/// Estado cargado del detalle de personaje
final class CharacterDetailsLoaded extends CharacterDetailsState {
  /// Constructor del estado cargado del detalle de personaje
  CharacterDetailsLoaded({required this.character});

  /// Personaje
  final Character character;
}

/// Estado error cargando el detalle de personaje
final class ErrorGettingDetails extends CharacterDetailsState {
  /// Constructor del estado error cargando el detalle de personaje
  ErrorGettingDetails(this.message);

  /// Mensaje de error
  final String message;
}
