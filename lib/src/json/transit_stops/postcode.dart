// ignore_for_file: prefer_final_parameters
import 'package:json_annotation/json_annotation.dart';

import 'transit_stop.dart';

part 'postcode.g.dart';

/// A postcode.
@JsonSerializable()
class Postcode extends TransitStop {
  /// Create an instance.
  const Postcode({
    required super.name,
    required super.latitude,
    required super.longitude,
    required super.accuracy,
  }) : super(code: name);

  /// Load an instance from [json].
  factory Postcode.fromJson(final Map<String, dynamic> json) =>
      _$PostcodeFromJson(json);

  /// Dump to JSON.
  @override
  Map<String, dynamic> toJson() => _$PostcodeToJson(this);
}
