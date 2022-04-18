import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../http.dart';
import '../json/app_preferences.dart';
import '../json/transit_stops/train_station.dart';
import '../json/transit_stops/transit_stop.dart';
import '../widgets/cancel.dart';
import '../widgets/center_text.dart';

/// A page for showing the given [stop].
class DeparturesPage extends StatefulWidget {
  /// Create an instance.
  const DeparturesPage({
    required this.stop,
    required this.preferences,
    // ignore: prefer_final_parameters
    super.key,
  });

  /// The stop to show departures for.
  final TransitStop stop;

  /// The app credentials to authenticate with.
  final AppPreferences preferences;

  /// Create state for this widget.
  @override
  DeparturesPageState createState() => DeparturesPageState();
}

/// State for [DeparturesPage].
class DeparturesPageState extends State<DeparturesPage> {
  /// Build a widget.
  @override
  Widget build(final BuildContext context) {
    final stop = widget.stop;
    loadDepartures();
    final isFavourite = widget.preferences.favouriteTransitStops
        .where((final element) => element.code == widget.stop.code)
        .isNotEmpty;
    return Cancel(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            ElevatedButton(
              onPressed: () {
                if (isFavourite) {
                  widget.preferences.favouriteTransitStops.removeWhere(
                    (final element) => element.code == widget.stop.code,
                  );
                } else {
                  widget.preferences.favouriteTransitStops.add(widget.stop);
                }
                widget.preferences.save();
                setState(() {});
              },
              child: isFavourite
                  ? const Icon(
                      Icons.bookmark_remove,
                      semanticLabel: 'Remove Favourite',
                    )
                  : const Icon(
                      Icons.bookmark_add,
                      semanticLabel: 'Add Favourite',
                    ),
            )
          ],
          title: Text(stop.name),
        ),
        body: CenterText(text: stop.name),
      ),
    );
  }

  /// Load the departures for this stop.
  Future<void> loadDepartures() async {
    final stop = widget.stop;
    final String url;
    if (stop is TrainStation) {
      url = 'train/station/${stop.code}/live.json';
    } else {
      url = 'bus/stop/${stop.code}/live.json';
    }
    final response = await get(
      credentials: widget.preferences.appCredentials!,
      path: url,
    );
    File('departures.json').writeAsStringSync(
      const JsonEncoder.withIndent('  ').convert(response.data),
    );
  }
}
