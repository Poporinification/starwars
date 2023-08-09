import 'package:dio/dio.dart';
import 'package:starwars/domain/repositories/http_repository.dart';

/// Clase de implementación del repositorio HTTP
class HTTPRepositoryImpl implements HTTPRepository {
  /// Constructor de la clase de implementación del repositorio HTTP
  HTTPRepositoryImpl() : _dio = Dio() {
    _dio
      ..interceptors.add(InterceptorsWrapper(onError: _onErrorHandler))
      ..options.connectTimeout = _connectionTimeout
      ..options.receiveTimeout = _receiveTimeout
      ..options.headers = _headers;
    assert(
      () {
        _dio.interceptors.add(
          LogInterceptor(
            requestBody: true,
            responseBody: true,
          ),
        );
        return true;
      }(),
      'Logger del cliente HTTP',
    );
  }

  final Dio _dio;
  final Duration _connectionTimeout = const Duration(milliseconds: 30000);
  final Duration _receiveTimeout = const Duration(milliseconds: 30000);
  final Map<String, dynamic> _headers = {
    'Accept': '*/*',
  };

  /// Manejador de errores de la petición HTTP
  void _onErrorHandler(DioException dioError, ErrorInterceptorHandler handler) {
    handler.reject(
      DioException(
        requestOptions: dioError.requestOptions,
        error: dioError.error,
        response: dioError.response,
        type: dioError.type,
        message: dioError.message,
      ),
    );
  }

  @override
  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic> queryParameters = const {},
  }) async {
    final response = await _dio.get<String>(
      path,
      queryParameters: queryParameters,
    );

    return response;
  }

  @override
  Future<Response<dynamic>> post(
    String path, {
    dynamic data,
    dynamic options,
    Map<String, dynamic> queryParameters = const {},
  }) async {
    return await _dio.post(
      path,
      data: data,
      options: options,
      queryParameters: queryParameters,
    );
  }
}
