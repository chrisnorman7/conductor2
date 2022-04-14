import 'package:json_annotation/json_annotation.dart';

part 'app_credentials.g.dart';

/// The credentials for an app.
@JsonSerializable()
class AppCredentials {
  /// Create an instance.
  const AppCredentials({required this.id, required this.key});

  /// Create an instance from a JSON object.
  factory AppCredentials.fromJson(final Map<String, dynamic> json) =>
      _$AppCredentialsFromJson(json);

  /// The app ID to use.
  final String id;

  /// The app key to use.
  final String key;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$AppCredentialsToJson(this);
}
