// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_exchange_rate.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedExchangeRateAdapter extends TypeAdapter<CachedExchangeRate> {
  @override
  final int typeId = 0;

  @override
  CachedExchangeRate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedExchangeRate(
      baseCurrency: fields[0] as String,
      conversionRates: (fields[1] as Map).cast<String, double>(),
      lastUpdated: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CachedExchangeRate obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.baseCurrency)
      ..writeByte(1)
      ..write(obj.conversionRates)
      ..writeByte(2)
      ..write(obj.lastUpdated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedExchangeRateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
