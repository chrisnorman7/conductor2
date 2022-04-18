// ignore_for_file: prefer_final_parameters

import 'package:json_annotation/json_annotation.dart';

import 'transit_stop.dart';

part 'tram_stop.g.dart';

/// A tram stop.
@JsonSerializable()
class TramStop extends TransitStop {
  /// Create an instance.
  const TramStop({
    required super.name,
    required super.latitude,
    required super.longitude,
    required super.accuracy,
    required super.code,
  });

  /// Load an instance from [json].
  factory TramStop.fromJson(final Map<String, dynamic> json) =>
      _$TramStopFromJson(json);

  /// Dump to JSON.
  @override
  Map<String, dynamic> toJson() => _$TramStopToJson(this);
}
