import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:starwars/data/const/endpoints_const.dart';
import 'package:starwars/data/respositories/character_repository_impl.dart';
import 'package:starwars/domain/entities/recordset.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/mock_runner_test.mocks.dart';

void main() {
  group('Repositorio: CharacterRepositoryImpl =>', () {
    late CharacterRepositoryImpl characterRepositoryImpl;
    late MockHTTPRepositoryImpl httpRepositoryImpl;

    int dummyPage = 1;
    Response response = Response(
      requestOptions: RequestOptions(path: ''),
      data: jsonEncode(dummyCharactersListJson),
      statusCode: 200,
      statusMessage: '',
    );

    setUp(() {
      httpRepositoryImpl = MockHTTPRepositoryImpl();

      characterRepositoryImpl = CharacterRepositoryImpl(
        httpRepository: httpRepositoryImpl,
      );
    });

    test('.getCharacters(int page)', () async {
      const url = '$swapiUrl$peopleEndpoint';
      final queryParameters = {'page': dummyPage.toString()};

      when(httpRepositoryImpl.get(url, queryParameters: queryParameters))
          .thenAnswer((_) async => response);

      expect(await characterRepositoryImpl.getCharacters(dummyPage),
          isA<Recordset>());

      verify(httpRepositoryImpl.get(url, queryParameters: queryParameters))
          .called(1);
    });

    test('.getCharacterHomeWorld(Character character)', () async {
      const url = 'https://swapi.dev/api/planets/1/';
      Response homeworldResponse = Response(
        requestOptions: RequestOptions(path: ''),
        data: jsonEncode({
          'name': 'Tatooine',
        }),
        statusCode: 200,
        statusMessage: '',
      );

      when(httpRepositoryImpl.get(url))
          .thenAnswer((_) async => homeworldResponse);

      expect(
        await characterRepositoryImpl.getCharacterHomeWorld(
          dummyCharacter,
        ),
        equals('Tatooine'),
      );

      verify(httpRepositoryImpl.get(url)).called(1);
    });

    test('.getCharacterVehicles(Character character)', () async {
      Response vehicleResponse = Response(
        requestOptions: RequestOptions(path: ''),
        data: jsonEncode({
          'name': 'Sand Crawler',
        }),
        statusCode: 200,
        statusMessage: '',
      );

      when(httpRepositoryImpl.get(any)).thenAnswer(
        (_) async => vehicleResponse,
      );

      expect(
        await characterRepositoryImpl.getCharacterVehicles(
          dummyCharacter,
        ),
        isA<List<String>>(),
      );

      verify(httpRepositoryImpl.get(any)).called(2);
    });

    test('.getCharacterStarships(Character character)', () async {
      Response starshipResponse = Response(
        requestOptions: RequestOptions(path: ''),
        data: jsonEncode({
          'name': 'Death Star',
        }),
        statusCode: 200,
        statusMessage: '',
      );

      when(httpRepositoryImpl.get(any)).thenAnswer(
        (_) async => starshipResponse,
      );

      expect(
        await characterRepositoryImpl.getCharacterStarships(
          dummyCharacter,
        ),
        isA<List<String>>(),
      );

      verify(httpRepositoryImpl.get(any)).called(2);
    });

    test('.reportCharacter(Character character)', () async {
      const url = '$baseUrl$postsEndpoint';
      Response reportResponse = Response(
        requestOptions: RequestOptions(path: ''),
        data: jsonEncode({}),
        statusCode: 200,
        statusMessage: '',
      );

      when(httpRepositoryImpl.post(any, data: anyNamed('data'))).thenAnswer(
        (_) async => reportResponse,
      );

      await characterRepositoryImpl.reportCharacter(
        dummyCharacter,
      );

      verify(httpRepositoryImpl.post(url, data: anyNamed('data'))).called(1);
    });
  });
}
