// ignore_for_file: prefer_final_parameters
import 'package:json_annotation/json_annotation.dart';

import 'transit_stop.dart';

part 'train_station.g.dart';

/// A train station.
@JsonSerializable()
class TrainStation extends TransitStop {
  /// Create an instance.
  const TrainStation({
    required super.name,
    required super.latitude,
    required super.longitude,
    required super.accuracy,
    required super.code,
  });

  /// Load an instance from [json].
  factory TrainStation.fromJson(final Map<String, dynamic> json) =>
      _$TrainStationFromJson(json);
}
