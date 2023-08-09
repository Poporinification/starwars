// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connecitivity_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConnectivityModelAdapter extends TypeAdapter<ConnectivityModel> {
  @override
  final int typeId = 0;

  @override
  ConnectivityModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConnectivityModel(
      hasConnection: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ConnectivityModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.hasConnection);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConnectivityModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
