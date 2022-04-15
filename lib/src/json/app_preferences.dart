import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_credentials.dart';
import 'gps_entry.dart';

part 'app_preferences.g.dart';

/// Application preferences.
@JsonSerializable()
class AppPreferences {
  /// Create an instance.
  AppPreferences({
    this.appCredentials,
    final List<GpsEntry>? favouriteTransitStops,
  }) : favouriteTransitStops = favouriteTransitStops ?? [];

  /// Create an instance from a JSON object.
  factory AppPreferences.fromJson(final Map<String, dynamic> json) =>
      _$AppPreferencesFromJson(json);

  /// The key where preferences will be stored.
  static const preferencesKey = 'app_preferences';

  /// The app credentials to use.
  AppCredentials? appCredentials;

  /// The favourite transit stops.
  final List<GpsEntry> favouriteTransitStops;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$AppPreferencesToJson(this);

  /// Save the preferences.
  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(toJson());
    await prefs.setString(preferencesKey, data);
  }
}
