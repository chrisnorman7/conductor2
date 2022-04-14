// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gps_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GpsEntry _$GpsEntryFromJson(Map<String, dynamic> json) => GpsEntry(
      type: $enumDecode(_$EntryTypeEnumMap, json['type']),
      name: json['name'] as String,
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      accuracy: (json['accuracy'] as num).toDouble(),
      description: json['description'] as String?,
      distance: (json['distance'] as num?)?.toDouble(),
      atcoCode: json['atcocode'] as String?,
      stationCode: json['station_code'] as String?,
      tiplocCode: json['tiploc_code'] as String?,
    );

Map<String, dynamic> _$GpsEntryToJson(GpsEntry instance) => <String, dynamic>{
      'type': _$EntryTypeEnumMap[instance.type],
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'accuracy': instance.accuracy,
      'distance': instance.distance,
      'atcocode': instance.atcoCode,
      'station_code': instance.stationCode,
      'tiploc_code': instance.tiplocCode,
      'description': instance.description,
    };

const _$EntryTypeEnumMap = {
  EntryType.postcode: 'postcode',
  EntryType.busStop: 'bus_stop',
  EntryType.tubeStation: 'tube_station',
  EntryType.tramStop: 'tram_stop',
  EntryType.trainStation: 'train_station',
};
