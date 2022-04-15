import 'package:json_annotation/json_annotation.dart';

import '../transit_stops/bus_stop.dart';
import '../transit_stops/postcode.dart';
import '../transit_stops/train_station.dart';
import '../transit_stops/tram_stop.dart';
import '../transit_stops/tube_station.dart';

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

  /// Get a title for this instance.
  String get title {
    final d = description;
    if (d == null) {
      return name;
    }
    return '$name ($d)';
  }

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$GpsEntryToJson(this);

  /// Convert this entry to a postcode.
  Postcode toPostcode() {
    if (type != EntryType.postcode) {
      throw StateError('This entry is a ${type.name}, not a postcode.');
    }
    return Postcode(
      name: title,
      latitude: latitude,
      longitude: longitude,
      accuracy: accuracy,
    );
  }

  /// Convert this entry to a bus stop.
  BusStop toBusStop() {
    if (type != EntryType.busStop) {
      throw StateError('This entry is a ${type.name}, not a bus stop.');
    }
    return BusStop(
      name: title,
      latitude: latitude,
      longitude: longitude,
      accuracy: accuracy,
      atcoCode: atcoCode!,
    );
  }

  /// Convert this entry to a tram stop.
  TramStop toTramStop() {
    if (type != EntryType.tramStop) {
      throw StateError('This entry is a ${type.name}, ot a tram stop.');
    }
    return TramStop(
      name: title,
      latitude: latitude,
      longitude: longitude,
      accuracy: accuracy,
      atcoCode: atcoCode!,
    );
  }

  /// Convert this entry to a train station.
  TrainStation toTrainStation() {
    if (type != EntryType.trainStation) {
      throw StateError('This entry is a ${type.name}, not a train station.');
    }
    return TrainStation(
      name: title,
      latitude: latitude,
      longitude: longitude,
      accuracy: accuracy,
      stationCode: stationCode,
      tiplocCode: tiplocCode,
    );
  }

  /// Convert this entry to a tube station.
  TubeStation toTubeStation() {
    if (type != EntryType.tubeStation) {
      throw StateError('This entry is a ${type.name}, not a tube station.');
    }
    return TubeStation(
      name: title,
      latitude: latitude,
      longitude: longitude,
      accuracy: accuracy,
      atcoCode: atcoCode!,
    );
  }
}
