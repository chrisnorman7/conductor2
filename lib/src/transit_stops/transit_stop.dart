/// The base class for all transit stops.
class TransitStop {
  /// Create an instance.
  const TransitStop({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.accuracy,
  });

  /// The name of this stop.
  final String name;

  /// The latitude coordinate of this stop.
  final double latitude;

  /// The latitude coordinate of this stop.
  final double longitude;

  /// The accuracy of the coordinates of this stop.
  final double accuracy;
}
