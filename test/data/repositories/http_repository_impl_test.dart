import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starwars/data/respositories/http_repository_impl.dart';
import 'package:starwars/domain/repositories/http_repository.dart';

void main() {
  group('Repositorio: HTTPRepositoryImpl =>', () {
    late HTTPRepository httpRepository;

    setUp(() {
      httpRepository = HTTPRepositoryImpl();
    });

    test('Debe crear una instancia de HTTPRepository ', () {
      expect(httpRepository, isA<HTTPRepository>());
    });

    group(
        '.post( String path, { dynamic data, dynamic options, Map<String, dynamic> queryParameters = const {},})',
        () {
      test('', () async {
        final response = await httpRepository
            .post('https://httpbin.org/post', data: {'test': 'test'});

        expect(response, isA<Response<dynamic>>());
        expect(response.data, isA<Map<String, dynamic>>());
      });

      test('Debe lanzar una excepción si la solicitud falla', () async {
        expect(
          () async =>
              await httpRepository.post('https://httpbin.org/status/401'),
          throwsException,
        );
        expect(
          () async =>
              await httpRepository.post('https://httpbin.org/status/403'),
          throwsException,
        );
        expect(
          () async =>
              await httpRepository.post('https://httpbin.org/status/404'),
          throwsException,
        );
        expect(
          () async =>
              await httpRepository.post('https://httpbin.org/status/500'),
          throwsException,
        );
        expect(
          () async =>
              await httpRepository.post('https://httpbin.org/status/503'),
          throwsException,
        );
        expect(
          () async =>
              await httpRepository.post('https://httpbin.org/status/504'),
          throwsException,
        );
      });

      test('Debe lanzar una excepción si la solicitud expira', () async {
        expect(
          () async => await httpRepository.post(
            'https://httpbin.org/delay/0.1',
            options: Options(receiveTimeout: const Duration(milliseconds: 1)),
          ),
          throwsException,
        );
      });
    });

    group('.get() method', () {
      test('should get the data from the given path', () async {
        final response = await httpRepository.get('https://httpbin.org/get');

        expect(response, isA<Response>());
        expect(response.data, isA<Map<String, dynamic>>());
      });

      test('should throw an exception if the request fails', () async {
        expect(
          () async =>
              await httpRepository.get('https://httpbin.org/status/401'),
          throwsException,
        );
        expect(
          () async =>
              await httpRepository.get('https://httpbin.org/status/403'),
          throwsException,
        );
        expect(
          () async =>
              await httpRepository.get('https://httpbin.org/status/404'),
          throwsException,
        );
        expect(
          () async =>
              await httpRepository.get('https://httpbin.org/status/500'),
          throwsException,
        );
        expect(
          () async =>
              await httpRepository.get('https://httpbin.org/status/503'),
          throwsException,
        );
        expect(
          () async =>
              await httpRepository.get('https://httpbin.org/status/504'),
          throwsException,
        );
      });
    });
  });
}
