// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Stretching.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StretchingAdapter extends TypeAdapter<Stretching> {
  @override
  final int typeId = 0;

  @override
  Stretching read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Stretching(
      fields[0] as String,
      fields[1] as int,
      fields[2] as int,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Stretching obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.series)
      ..writeByte(2)
      ..write(obj.repeats)
      ..writeByte(3)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StretchingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
