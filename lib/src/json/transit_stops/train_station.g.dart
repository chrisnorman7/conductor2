// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'train_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrainStation _$TrainStationFromJson(Map<String, dynamic> json) => TrainStation(
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      accuracy: (json['accuracy'] as num).toDouble(),
      code: json['code'] as String,
    );

Map<String, dynamic> _$TrainStationToJson(TrainStation instance) =>
    <String, dynamic>{
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'accuracy': instance.accuracy,
      'code': instance.code,
    };
