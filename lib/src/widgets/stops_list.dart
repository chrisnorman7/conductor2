import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../util.dart';
import '../json/app_preferences.dart';
import '../json/gps_entry.dart';
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
  final List<GpsEntry> stops;

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
          final entry = widget.stops[index];
          TransitStop? stop;
          switch (entry.type) {
            case EntryType.postcode:
              break;
            case EntryType.busStop:
              stop = entry.toBusStop();
              break;
            case EntryType.tubeStation:
              stop = entry.toTubeStation();
              break;
            case EntryType.tramStop:
              stop = entry.toTramStop();
              break;
            case EntryType.trainStation:
              stop = entry.toTrainStation();
              break;
          }
          final position = widget.position;
          final distance = position == null
              ? entry.distance
              : Geolocator.distanceBetween(
                  position.latitude,
                  position.longitude,
                  entry.latitude,
                  entry.longitude,
                );
          return ListTile(
            autofocus: index == 0,
            title: Text(entry.title),
            subtitle: Text(
              distance == null
                  ? 'Unknown'
                  : sensibleDistance(
                      distance,
                    ),
            ),
            onTap: stop == null
                ? null
                : () async {
                    await pushWidget(
                      context: context,
                      builder: (final context) => DeparturesPage(
                        stop: stop!,
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
