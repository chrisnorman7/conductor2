import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../util.dart';
import '../json/app_preferences.dart';
import '../json/transit_stops/transit_stop.dart';
import '../screens/departures_page.dart';

/// A widget to view a list of.
class StopsList extends StatefulWidget {
  /// Create an instance.
  const StopsList({
    required this.stops,
    required this.appPreferences,
    this.position,
    // ignore: prefer_final_parameters
    super.key,
  });

  /// The stops to show.
  final List<TransitStop> stops;

  /// The app preferences to use.
  final AppPreferences appPreferences;

  /// The current GPS position.
  final Position? position;
  @override
  State<StopsList> createState() => _StopsListState();
}

class _StopsListState extends State<StopsList> {
  /// Build the widget.
  @override
  Widget build(final BuildContext context) => ListView.builder(
        itemBuilder: (final context, final index) {
          final stop = widget.stops[index];
          final position = widget.position;
          final distance = position == null
              ? null
              : Geolocator.distanceBetween(
                  position.latitude,
                  position.longitude,
                  stop.latitude,
                  stop.longitude,
                );
          return ListTile(
            autofocus: index == 0,
            title: Text(stop.name),
            subtitle: Text(
              distance == null
                  ? 'Unknown'
                  : sensibleDistance(
                      distance,
                    ),
            ),
            onTap: () async {
              await pushWidget(
                context: context,
                builder: (final context) => DeparturesPage(
                  stop: stop,
                  preferences: widget.appPreferences,
                ),
              );
              setState(() {});
            },
          );
        },
        itemCount: widget.stops.length,
      );
}
