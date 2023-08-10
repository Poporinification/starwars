import 'dart:convert';

import 'package:starwars/data/const/endpoints_const.dart';
import 'package:starwars/data/model/character_record_model.dart';
import 'package:starwars/domain/entities/character.dart';
import 'package:starwars/domain/entities/recordset.dart';
import 'package:starwars/domain/repositories/character_repository.dart';
import 'package:starwars/domain/repositories/http_repository.dart';

/// /// Clase que implementa CharacterRepository
class CharacterRepositoryImpl implements CharacterRepository {
  /// Constructor de la clase
  CharacterRepositoryImpl({
    required this.httpRepository,
  });

  /// Instancia del repositorio HTTP
  final HTTPRepository httpRepository;

  @override
  Future<Recordset> getCharacters(int page) async {
    final response = await httpRepository.get(
      '$swapiUrl$peopleEndpoint',
      queryParameters: {'page': page.toString()},
    );

    return RecordSetModel.fromJson(jsonDecode(response.data)).toEntity();
  }

  @override
  Future<String> getCharacterHomeWorld(Character character) async {
    if (character.homeworld.isEmpty) {
      return '';
    }
    final response = await httpRepository.get(character.homeworld);
    return jsonDecode(response.data)['name'];
  }

  @override
  Future<List<String>> getCharacterVehicles(Character character) async {
    final vehicles = <String>[];
    for (final vehicleUrl in character.vehicles) {
      final response = await httpRepository.get(vehicleUrl);
      vehicles.add(jsonDecode(response.data)['name']);
    }
    return character.vehicles = vehicles;
  }

  @override
  Future<List<String>> getCharacterStarships(Character character) async {
    final starships = <String>[];
    for (final starshipUrl in character.starships) {
      final response = await httpRepository.get(starshipUrl);
      starships.add(jsonDecode(response.data)['name']);
    }
    return character.starships = starships;
  }

  @override
  Future<void> reportCharacter(Character character) async {
    await httpRepository.post(
      '$baseUrl$postsEndpoint',
      data: {
        "userId": character.id,
        "dateTime": DateTime.now().toIso8601String().replaceAll('T', ' '),
        "character_name": character.name,
      },
    );
  }
}
