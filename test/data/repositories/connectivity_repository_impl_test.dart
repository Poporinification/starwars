import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:starwars/data/respositories/connectivity_repository_impl.dart';
import 'package:starwars/domain/entities/connetivity.dart';

import '../../helpers/mock_runner_test.mocks.dart';

void main() {
  group('Repositorio: ConnectivityRepositoryImpl =>', () {
    late ConnectivityRepositoryImpl characterRepositoryImpl;
    late MockStorageRepositoryImpl mockStorageRepositoryImpl;

    const boxName = 'connectivity';

    setUp(() {
      mockStorageRepositoryImpl = MockStorageRepositoryImpl();

      characterRepositoryImpl = ConnectivityRepositoryImpl(
        storageRepository: mockStorageRepositoryImpl,
      );
    });

    test('.hasStoredConnectivityStatus()', () async {
      when(mockStorageRepositoryImpl.isExists(boxName: boxName)).thenAnswer(
        (_) async => true,
      );

      expect(await characterRepositoryImpl.hasStoredConnectivityStatus(), true);

      verify(mockStorageRepositoryImpl.isExists(boxName: boxName)).called(1);
    });

    test('.saveConnectivityStatus(bool isConnected)', () async {
      await characterRepositoryImpl.saveConnectivityStatus(true);
      verify(mockStorageRepositoryImpl.addBoxes(any, boxName)).called(1);
    });

    test('.updateConnectivityStatus(bool isConnected)', () async {
      await characterRepositoryImpl.updateConnectivityStatus(true);
      verify(mockStorageRepositoryImpl.putBox(boxName, any)).called(1);
    });

    test('.getConnectivityStatus()', () async {
      when(mockStorageRepositoryImpl.getBoxes(boxName)).thenAnswer(
        (_) async => [
          {
            'hasConnection': true,
          }
        ],
      );

      expect(
        await characterRepositoryImpl.getConnectivityStatus(),
        isA<Connectivity>(),
      );

      verify(mockStorageRepositoryImpl.getBoxes(boxName)).called(1);
    });
  });
}
