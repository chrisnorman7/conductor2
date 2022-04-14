// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gps_entries.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GpsEntries _$GpsEntriesFromJson(Map<String, dynamic> json) => GpsEntries(
      requestTime: DateTime.parse(json['request_time'] as String),
      entries: (json['member'] as List<dynamic>)
          .map((e) => GpsEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      acknowledgements: json['acknowledgements'] as String? ?? 'Nobody',
      source: json['source'] as String? ?? 'Code',
    );

Map<String, dynamic> _$GpsEntriesToJson(GpsEntries instance) =>
    <String, dynamic>{
      'request_time': instance.requestTime.toIso8601String(),
      'source': instance.source,
      'acknowledgements': instance.acknowledgements,
      'member': instance.entries,
    };
