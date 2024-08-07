// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DayFood.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayFoodAdapter extends TypeAdapter<DayFood> {
  @override
  final int typeId = 4;

  @override
  DayFood read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayFood(
      fields[0] as DateTime,
      (fields[1] as List).cast<Food>(),
      fields[2] as int,
      fields[3] as int,
      fields[4] as int,
      fields[5] as int,
      fields[8] as int,
      fields[6] as int,
      fields[7] as int,
      fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DayFood obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.foodList)
      ..writeByte(2)
      ..write(obj.calories_counter)
      ..writeByte(3)
      ..write(obj.carbs_counter)
      ..writeByte(4)
      ..write(obj.fat_counter)
      ..writeByte(5)
      ..write(obj.proteins_counter)
      ..writeByte(6)
      ..write(obj.carbs_limit)
      ..writeByte(7)
      ..write(obj.fat_limit)
      ..writeByte(8)
      ..write(obj.calories_limit)
      ..writeByte(9)
      ..write(obj.proteins_limit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayFoodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
