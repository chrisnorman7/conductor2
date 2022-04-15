// ignore_for_file: prefer_final_parameters

import 'transit_stop.dart';

/// A tram stop.
class TramStop extends TransitStop {
  /// Create an instance.
  const TramStop({
    required super.name,
    required super.latitude,
    required super.longitude,
    required super.accuracy,
    required this.atcoCode,
  });

  /// The atco code for this tram stop.
  final String atcoCode;
}
