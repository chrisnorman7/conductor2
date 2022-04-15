// ignore_for_file: prefer_final_parameters

import 'transit_stop.dart';

/// A tube station.
class TubeStation extends TransitStop {
  /// Create an instance.
  const TubeStation({
    required super.name,
    required super.latitude,
    required super.longitude,
    required super.accuracy,
    required this.atcoCode,
  });

  /// The atco code for this station.
  final String atcoCode;
}
