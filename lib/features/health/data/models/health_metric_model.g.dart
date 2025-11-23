// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_metric_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HealthMetricModelAdapter extends TypeAdapter<HealthMetricModel> {
  @override
  final int typeId = 0;

  @override
  HealthMetricModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HealthMetricModel(
      name: fields[0] as String,
      value: fields[1] as double,
      unit: fields[2] as String,
      status: fields[3] as String,
      range: fields[4] as String,
      history: (fields[5] as List).cast<double>(),
    );
  }

  @override
  void write(BinaryWriter writer, HealthMetricModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.unit)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.range)
      ..writeByte(5)
      ..write(obj.history);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthMetricModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
