// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConfigAdapter extends TypeAdapter<Config> {
  @override
  final int typeId = 2;

  @override
  Config read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Config(
      apiHost: fields[0] as String,
      apiPort: fields[2] as int,
      apiPath: fields[1] as String,
      sessionDuration: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Config obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.apiHost)
      ..writeByte(1)
      ..write(obj.apiPath)
      ..writeByte(2)
      ..write(obj.apiPort)
      ..writeByte(3)
      ..write(obj.sessionDuration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
