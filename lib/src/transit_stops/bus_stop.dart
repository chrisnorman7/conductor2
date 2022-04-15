// ignore_for_file: prefer_final_parameters

import 'transit_stop.dart';

/// A bus stop.
class BusStop extends TransitStop {
  /// Create an instance.
  const BusStop({
    required super.name,
    required super.latitude,
    required super.longitude,
    required super.accuracy,
    required this.atcoCode,
  });

  /// The atco code for this stop.
  final String atcoCode;
}
