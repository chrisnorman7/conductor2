import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../json/app_preferences.dart';
import '../json/gps_entries.dart';
import '../widgets/tabbed_scaffold.dart';
import 'tabs/gps_info.dart';
import 'tabs/public_transport/favourite_stops.dart';
import 'tabs/public_transport/nearby_stops.dart';

/// The main page for the app.
class MainPage extends StatefulWidget {
  /// Create an instance.
  const MainPage({
    required this.appPreferences,
    required this.clearCredentials,
    required this.controller,
    // ignore: prefer_final_parameters
    super.key,
  });

  /// The app credentials to work with.
  final AppPreferences appPreferences;

  /// The function to call to clear app credentials.
  final VoidCallback clearCredentials;

  /// The stream controller to pass to widgets.
  final StreamController<Position> controller;

  /// Create state for this widget.
  @override
  MainPageState createState() => MainPageState();
}

/// State for [MainPage].
class MainPageState extends State<MainPage> {
  late final StreamSubscription<Position> _streamSubscription;
  Position? _position;
  GpsEntries? _gpsEntries;

  /// Start listening.
  @override
  void initState() {
    super.initState();
    _streamSubscription =
        widget.controller.stream.listen((final event) => _position = event);
  }

  /// Build a widget.
  @override
  Widget build(final BuildContext context) => TabbedScaffold(
        tabs: [
          TabbedScaffoldTab(
            title: 'Public Transport',
            icon: const Icon(Icons.emoji_transportation),
            topTabs: [
              TopTab(
                builder: (final context) => FavouriteStops(
                  preferences: widget.appPreferences,
                  controller: widget.controller,
                  initialPosition: _position,
                ),
                text: 'Favourites',
                icon: const Icon(Icons.bookmarks),
              ),
              TopTab(
                builder: (final context) => NearbyStops(
                  preferences: widget.appPreferences,
                  controller: widget.controller,
                  initialPosition: _position,
                  gpsEntries: _gpsEntries,
                  cachePositions: (final entries) => _gpsEntries = entries,
                ),
                text: 'Nearby',
                icon: const Icon(Icons.near_me),
              ),
            ],
            actions: [
              ElevatedButton(
                onPressed: widget.clearCredentials,
                child: const Icon(
                  Icons.clear,
                  semanticLabel: 'Clear Credentials',
                ),
              )
            ],
          ),
          TabbedScaffoldTab(
            title: 'GPS Information',
            icon: const Icon(Icons.info),
            builder: (final context) => GpsInfo(
              controller: widget.controller,
              initialPosition: _position,
            ),
          )
        ],
      );

  /// Stop listening.
  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }
}
