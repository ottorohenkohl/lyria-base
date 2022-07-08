// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionAdapter extends TypeAdapter<Session> {
  @override
  final int typeId = 3;

  @override
  Session read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Session(
      cookie: fields[0] as String,
      entity: fields[1] as dynamic,
    )..validity = fields[2] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, Session obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.cookie)
      ..writeByte(1)
      ..write(obj.entity)
      ..writeByte(2)
      ..write(obj.validity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
