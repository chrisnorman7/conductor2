import 'package:json_annotation/json_annotation.dart';

part 'transit_stop.g.dart';

/// The base class for all transit stops.
@JsonSerializable()
class TransitStop {
  /// Create an instance.
  const TransitStop({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.code,
  });

  /// Load an instance from [json].
  factory TransitStop.fromJson(final Map<String, dynamic> json) =>
      _$TransitStopFromJson(json);

  /// The name of this stop.
  final String name;

  /// The latitude coordinate of this stop.
  final double latitude;

  /// The latitude coordinate of this stop.
  final double longitude;

  /// The accuracy of the coordinates of this stop.
  final double accuracy;

  /// The code for this stop.
  ///
  /// This value will be the station code for train stations, and the ATCO code
  /// for everything else.
  final String code;

  /// Dump to JSON.
  Map<String, dynamic> toJson() => _$TransitStopToJson(this);
}
