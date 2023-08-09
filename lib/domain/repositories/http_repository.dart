/// Interfaz que define los métodos para realizar peticiones HTTP
abstract class HTTPRepository {
  /// Realiza una petición GET a la API
  Future<dynamic> get(
    String path, {
    Map<String, dynamic> queryParameters = const {},
  });

  /// Realiza una petición POST a la API
  Future<dynamic> post(
    String path, {
    dynamic data,
    dynamic options,
    Map<String, dynamic> queryParameters = const {},
  });
}
