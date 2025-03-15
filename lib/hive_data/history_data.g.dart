// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryDataAdapter extends TypeAdapter<HistoryData> {
  @override
  final int typeId = 2;

  @override
  HistoryData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryData(
      boardId: fields[0] as String,
      date: fields[1] as DateTime,
      correct: fields[2] as int,
      wrong: fields[3] as int,
      empty: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HistoryData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.boardId)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.correct)
      ..writeByte(3)
      ..write(obj.wrong)
      ..writeByte(4)
      ..write(obj.empty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
