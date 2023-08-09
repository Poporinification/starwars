import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:starwars/domain/observable/connection_observable.dart';
import 'package:starwars/domain/use_cases/toggle_connectivity_status_use_case.dart';

import '../../helpers/mock_runner_test.mocks.dart';

void main() {
  group('Caso de uso: ToggleConnectivityStatusUseCase =>', () {
    late ToggleConnectivityStatusUseCase toggleConnectivityStatusUseCase;
    late MockConnectivityRepositoryImpl mockConnectivityRepositoryImpl;

    bool isConnected = true;
    ConnectionObservable connectionObservable = ConnectionObservable();

    setUp(() {
      mockConnectivityRepositoryImpl = MockConnectivityRepositoryImpl();

      toggleConnectivityStatusUseCase = ToggleConnectivityStatusUseCase(
        mockConnectivityRepositoryImpl,
      );
    });

    test(
        '.execute({required bool isConnected, required ConnectionObservable connectionObservable}) sin datos almacenados de conexión',
        () async {
      when(mockConnectivityRepositoryImpl.hasStoredConnectivityStatus())
          .thenAnswer((_) async => false);

      await toggleConnectivityStatusUseCase.execute(
        isConnected: isConnected,
        connectionObservable: connectionObservable,
      );

      verify(mockConnectivityRepositoryImpl.hasStoredConnectivityStatus())
          .called(1);
      verify(mockConnectivityRepositoryImpl.saveConnectivityStatus(isConnected))
          .called(1);
    });

    test(
        '.execute({required bool isConnected, required ConnectionObservable connectionObservable}) con datos almacenados de conexión',
        () async {
      when(mockConnectivityRepositoryImpl.hasStoredConnectivityStatus())
          .thenAnswer((_) async => true);

      await toggleConnectivityStatusUseCase.execute(
        isConnected: isConnected,
        connectionObservable: connectionObservable,
      );

      verify(mockConnectivityRepositoryImpl.hasStoredConnectivityStatus())
          .called(1);
      verify(mockConnectivityRepositoryImpl
              .updateConnectivityStatus(isConnected))
          .called(1);
    });
  });
}
