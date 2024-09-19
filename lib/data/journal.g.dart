// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JournalAdapter extends TypeAdapter<Journal> {
  @override
  final int typeId = 3;

  @override
  Journal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Journal(
      className: fields[0] as String?,
      journal: (fields[1] as Map?)?.map((dynamic k, dynamic v) => MapEntry(
          k as String,
          (v as Map).map((dynamic k, dynamic v) =>
              MapEntry(k as String, (v as List).cast<String>())))),
    );
  }

  @override
  void write(BinaryWriter writer, Journal obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.className)
      ..writeByte(1)
      ..write(obj.journal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JournalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
