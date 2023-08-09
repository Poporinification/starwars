import 'package:hive/hive.dart';
import 'package:starwars/domain/repositories/storage_repository.dart';

/// Clase que implementa StorageRepository
class StorageRepositoryImpl implements StorageRepository {
  /// Constructor de la clase
  StorageRepositoryImpl();

  @override
  Future<bool> isExists({required String boxName}) async {
    final openBox = await Hive.openBox(boxName);
    final length = openBox.length;
    return length != 0;
  }

  @override
  Future<void> addBoxes<T>(List<T> items, String boxName) async {
    final openBox = await Hive.openBox(boxName);

    for (final item in items) {
      await openBox.add(item);
    }
  }

  @override
  Future<List<T>> getBoxes<T>(String boxName) async {
    final boxList = <T>[];

    final openBox = await Hive.openBox(boxName);

    final length = openBox.length;

    for (var i = 0; i < length; i++) {
      boxList.add(openBox.getAt(i));
    }

    return boxList;
  }

  @override
  void putBox<T>(String boxName, T item, {int index = 0}) {
    Hive.box(boxName).putAt(index, item);
  }
}
