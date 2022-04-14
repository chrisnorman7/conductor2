import 'package:flutter/material.dart';

import '../json/app_preferences.dart';
import '../widgets/stops_list.dart';
import '../widgets/tabbed_scaffold.dart';
import 'tabs/gps_info.dart';
import 'tabs/public_transport/nearby_stops.dart';

/// The main page for the app.
class MainPage extends StatefulWidget {
  /// Create an instance.
  const MainPage({
    required this.appPreferences,
    required this.clearCredentials,
    // ignore: prefer_final_parameters
    super.key,
  });

  /// The app credentials to work with.
  final AppPreferences appPreferences;

  /// The function to call to clear app credentials.
  final VoidCallback clearCredentials;

  /// Create state for this widget.
  @override
  MainPageState createState() => MainPageState();
}

/// State for [MainPage].
class MainPageState extends State<MainPage> {
  /// Build a widget.
  @override
  Widget build(final BuildContext context) => TabbedScaffold(
        tabs: [
          TabbedScaffoldTab(
            title: 'Public Transport',
            icon: const Icon(Icons.emoji_transportation),
            topTabs: [
              TopTab(
                builder: (final context) => StopsList(
                  appPreferences: widget.appPreferences,
                ),
                text: 'Favourites',
                icon: const Icon(Icons.bookmarks),
              ),
              TopTab(
                builder: (final context) => NearbyStops(
                  credentials: widget.appPreferences.appCredentials!,
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
            builder: (final context) => const GpsInfo(),
          )
        ],
      );
}
