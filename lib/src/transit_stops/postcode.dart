// ignore_for_file: prefer_final_parameters

import 'transit_stop.dart';

/// A postcode.
class Postcode extends TransitStop {
  /// Create an instance.
  const Postcode({
    required super.name,
    required super.latitude,
    required super.longitude,
    required super.accuracy,
  });
}
