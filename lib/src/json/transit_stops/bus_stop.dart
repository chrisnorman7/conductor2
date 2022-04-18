// ignore_for_file: prefer_final_parameters
import 'package:json_annotation/json_annotation.dart';

import 'transit_stop.dart';

part 'bus_stop.g.dart';

/// A bus stop.
@JsonSerializable()
class BusStop extends TransitStop {
  /// Create an instance.
  const BusStop({
    required super.name,
    required super.latitude,
    required super.longitude,
    required super.accuracy,
    required super.code,
  });

  /// Load an instance from [json].
  factory BusStop.fromJson(final Map<String, dynamic> json) =>
      _$BusStopFromJson(json);

  /// Dump to json.
  @override
  Map<String, dynamic> toJson() => _$BusStopToJson(this);
}
