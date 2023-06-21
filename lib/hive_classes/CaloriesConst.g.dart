// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CaloriesConst.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CaloriesConstAdapter extends TypeAdapter<CaloriesConst> {
  @override
  final int typeId = 3;

  @override
  CaloriesConst read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CaloriesConst(
      fields[0] as int,
      fields[1] as int,
      fields[2] as int,
      fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CaloriesConst obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.calories_const)
      ..writeByte(1)
      ..write(obj.carbs_const)
      ..writeByte(2)
      ..write(obj.fat_const)
      ..writeByte(3)
      ..write(obj.proteins_const);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CaloriesConstAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
