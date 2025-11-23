// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HealthDataModelAdapter extends TypeAdapter<HealthDataModel> {
  @override
  final int typeId = 1;

  @override
  HealthDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HealthDataModel(
      user: fields[0] as String,
      lastUpdated: fields[1] as String,
      metrics: (fields[2] as List).cast<HealthMetricModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, HealthDataModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.user)
      ..writeByte(1)
      ..write(obj.lastUpdated)
      ..writeByte(2)
      ..write(obj.metrics);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
