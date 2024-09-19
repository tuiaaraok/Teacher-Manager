// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TestAdapter extends TypeAdapter<Test> {
  @override
  final int typeId = 1;

  @override
  Test read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Test(
      className: fields[0] as String?,
      elemDate: (fields[1] as List?)?.cast<TestInfo>(),
    );
  }

  @override
  void write(BinaryWriter writer, Test obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.className)
      ..writeByte(1)
      ..write(obj.elemDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TestInfoAdapter extends TypeAdapter<TestInfo> {
  @override
  final int typeId = 2;

  @override
  TestInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TestInfo(
      question: fields[0] as String?,
      answer: (fields[1] as List?)?.cast<String>(),
      isAnwer: (fields[2] as List?)?.cast<bool>(),
    );
  }

  @override
  void write(BinaryWriter writer, TestInfo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.question)
      ..writeByte(1)
      ..write(obj.answer)
      ..writeByte(2)
      ..write(obj.isAnwer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
