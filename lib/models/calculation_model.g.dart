// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalculationModelAdapter extends TypeAdapter<CalculationModel> {
  @override
  final int typeId = 0;

  @override
  CalculationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalculationModel()
      ..name = fields[0] as String?
      ..age = fields[1] as int?
      ..weight = fields[2] as double?
      ..height = fields[3] as double?
      ..bmi = fields[4] as double?
      ..diagnostic = fields[5] as String?;
  }

  @override
  void write(BinaryWriter writer, CalculationModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.age)
      ..writeByte(2)
      ..write(obj.weight)
      ..writeByte(3)
      ..write(obj.height)
      ..writeByte(4)
      ..write(obj.bmi)
      ..writeByte(5)
      ..write(obj.diagnostic);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalculationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
