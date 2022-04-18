// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppPreferences _$AppPreferencesFromJson(Map<String, dynamic> json) =>
    AppPreferences(
      appCredentials: json['appCredentials'] == null
          ? null
          : AppCredentials.fromJson(
              json['appCredentials'] as Map<String, dynamic>),
      favouriteTransitStops: (json['favouriteTransitStops'] as List<dynamic>?)
          ?.map((e) => TransitStop.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AppPreferencesToJson(AppPreferences instance) =>
    <String, dynamic>{
      'appCredentials': instance.appCredentials,
      'favouriteTransitStops': instance.favouriteTransitStops,
    };
