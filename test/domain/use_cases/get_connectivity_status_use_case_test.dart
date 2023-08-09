import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:starwars/domain/entities/connetivity.dart';
import 'package:starwars/domain/use_cases/get_connectivity_status_use_case.dart';

import '../../helpers/mock_runner_test.mocks.dart';

void main() {
  group('Caso de uso: GetConnectivityStatusUseCase =>', () {
    late GetConnectivityStatusUseCase getConnectivityStatusUseCase;
    late MockConnectivityRepositoryImpl connectivityRepositoryImpl;

    Connectivity connectivity = Connectivity(
      hasConnection: true,
    );

    setUp(() {
      connectivityRepositoryImpl = MockConnectivityRepositoryImpl();

      getConnectivityStatusUseCase = GetConnectivityStatusUseCase(
        connectivityRepositoryImpl,
      );
    });

    test('.execute()', () async {
      when(connectivityRepositoryImpl.getConnectivityStatus())
          .thenAnswer((_) async => connectivity);

      await getConnectivityStatusUseCase.execute();

      expect(connectivity.hasConnection, true);

      verify(connectivityRepositoryImpl.getConnectivityStatus());
    });
  });
}
