// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homework.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomeworkAdapter extends TypeAdapter<Homework> {
  @override
  final int typeId = 4;

  @override
  Homework read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Homework(
      className: fields[0] as String?,
      today: fields[1] as String?,
      surrender: fields[2] as String?,
      task: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Homework obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.className)
      ..writeByte(1)
      ..write(obj.today)
      ..writeByte(2)
      ..write(obj.surrender)
      ..writeByte(3)
      ..write(obj.task);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeworkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
