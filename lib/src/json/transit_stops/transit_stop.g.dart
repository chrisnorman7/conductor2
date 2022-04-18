// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transit_stop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransitStop _$TransitStopFromJson(Map<String, dynamic> json) => TransitStop(
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      accuracy: (json['accuracy'] as num).toDouble(),
      code: json['code'] as String,
    );

Map<String, dynamic> _$TransitStopToJson(TransitStop instance) =>
    <String, dynamic>{
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'accuracy': instance.accuracy,
      'code': instance.code,
    };
