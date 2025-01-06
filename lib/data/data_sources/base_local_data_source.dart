import 'package:isar/isar.dart';

class BaseLocalDataSource<T> {
  BaseLocalDataSource(this.isar);

  Isar isar;
  IsarCollection<T> get currentCollection => isar.collection<T>();
}
