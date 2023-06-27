// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Gym.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GymAdapter extends TypeAdapter<Gym> {
  @override
  final int typeId = 6;

  @override
  Gym read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Gym(
      fields[0] as String,
      fields[1] as String,
      fields[2] as int,
      fields[3] as int,
      fields[4] as String,
      fields[5] as String,
      fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Gym obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.series)
      ..writeByte(3)
      ..write(obj.repeats)
      ..writeByte(4)
      ..write(obj.seriesTime)
      ..writeByte(5)
      ..write(obj.breakTime)
      ..writeByte(6)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GymAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
