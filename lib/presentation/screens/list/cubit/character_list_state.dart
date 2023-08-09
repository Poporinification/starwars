part of 'character_list_cubit.dart';

/// Estado del listado de personajes
sealed class CharacterListState {}

/// Estado inicial del listado de personajes
final class CharactersListInitialState extends CharacterListState {}

/// Estado cargando el listado de personajes
final class GettingCharacters extends CharacterListState {}

/// Estado cargado del listado de personajes
final class CharactersLoaded extends CharacterListState {
  /// Constructor del estado cargado del listado de personajes
  CharactersLoaded({required this.recordSet});

  /// Conjunto de registros
  final Recordset recordSet;
}

/// Estado error cargando el listado de personajes
final class ErrorGettingCharacters extends CharacterListState {
  /// Constructor del estado error cargando el listado de personajes
  ErrorGettingCharacters(this.message);

  /// Mensaje de error
  final String message;
}
