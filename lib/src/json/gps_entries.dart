import 'package:json_annotation/json_annotation.dart';

import 'gps_entry.dart';

part 'gps_entries.g.dart';

/// A list of gps [entries].
@JsonSerializable()
class GpsEntries {
  /// Create an instance.
  const GpsEntries({
    required this.requestTime,
    required this.entries,
    this.acknowledgements = 'Nobody',
    this.source = 'Code',
  });

  /// Create an instance from a JSON object.
  factory GpsEntries.fromJson(final Map<String, dynamic> json) =>
      _$GpsEntriesFromJson(json);

  /// The time these entries were received.
  @JsonKey(name: 'request_time')
  final DateTime requestTime;

  /// The source that provided these entries.
  final String source;

  /// The acknowledgements for the data.
  final String acknowledgements;

  /// The entries this class represents.
  @JsonKey(name: 'member')
  final List<GpsEntry> entries;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$GpsEntriesToJson(this);
}
