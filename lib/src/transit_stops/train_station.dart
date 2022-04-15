// ignore_for_file: prefer_final_parameters

import 'transit_stop.dart';

/// A train station.
class TrainStation extends TransitStop {
  /// Create an instance.
  const TrainStation({
    required super.name,
    required super.latitude,
    required super.longitude,
    required super.accuracy,
    this.stationCode,
    this.tiplocCode,
  }) : assert(
          stationCode != null || tiplocCode != null,
          'You must provide at least one of `stationCode` or `tiplocCode`.',
        );

  /// The code for this station.
  final String? stationCode;

  /// The tiploc code for this station.
  final String? tiplocCode;

  /// Get the appropriate code for this station.
  String get code {
    if (stationCode != null) {
      return 'crs:$stationCode';
    }
    return 'tiploc:$tiplocCode';
  }
}
