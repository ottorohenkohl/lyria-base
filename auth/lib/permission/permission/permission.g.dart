// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PermissionAdapter extends TypeAdapter<Permission> {
  @override
  final int typeId = 5;

  @override
  Permission read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Permission(
      user: fields[0] as User,
      value: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Permission obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.user)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PermissionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
