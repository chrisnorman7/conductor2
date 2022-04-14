import 'package:json_annotation/json_annotation.dart';

part 'gps_entry.g.dart';

/// The type of a [GpsEntry].
enum EntryType {
  /// A postcode entry.
  @JsonValue('postcode')
  postcode,

  /// A bus stop entry.
  @JsonValue('bus_stop')
  busStop,

  /// A tube station entry.
  @JsonValue('tube_station')
  tubeStation,

  /// A tram stop entry.
  @JsonValue('tram_stop')
  tramStop,

  /// A train station entry.
  @JsonValue('train_station')
  trainStation,
}

/// A GPS entry.
@JsonSerializable()
class GpsEntry {
  /// Create an instance.
  const GpsEntry({
    required this.type,
    required this.name,
    required this.longitude,
    required this.latitude,
    required this.accuracy,
    this.description,
    this.distance,
    this.atcoCode,
    this.stationCode,
    this.tiplocCode,
  });

  /// Create an instance from a JSON object.
  factory GpsEntry.fromJson(final Map<String, dynamic> json) =>
      _$GpsEntryFromJson(json);

  /// The type of this entry.
  final EntryType type;

  /// The name of this entry.
  final String name;

  /// The latitude coordinate of this entry.
  final double latitude;

  /// The longitude entry for this entry.
  final double longitude;

  /// The accuracy of this entry.
  final double accuracy;

  /// How far away this entry is.
  final double? distance;

  /// The code for a transit stop.
  @JsonKey(name: 'atcocode')
  final String? atcoCode;

  /// The code for a train station.
  @JsonKey(name: 'station_code')
  final String? stationCode;

  /// The tiploc code for a train station.
  @JsonKey(name: 'tiploc_code')
  final String? tiplocCode;

  /// The description of this entry.
  final String? description;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$GpsEntryToJson(this);
}
