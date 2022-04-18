// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tram_stop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TramStop _$TramStopFromJson(Map<String, dynamic> json) => TramStop(
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      accuracy: (json['accuracy'] as num).toDouble(),
      code: json['code'] as String,
    );

Map<String, dynamic> _$TramStopToJson(TramStop instance) => <String, dynamic>{
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'accuracy': instance.accuracy,
      'code': instance.code,
    };
