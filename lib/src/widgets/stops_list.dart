import 'package:flutter/material.dart';

import '../../util.dart';
import '../json/app_preferences.dart';
import '../json/gps_entry.dart';
import '../screens/departures_page.dart';
import '../transit_stops/transit_stop.dart';

/// A widget to view a list of.
class StopsList extends StatefulWidget {
  /// Create an instance.
  const StopsList({
    required this.stops,
    required this.appPreferences,
    // ignore: prefer_final_parameters
    super.key,
  });

  /// The stops to show.
  final List<GpsEntry> stops;

  /// The app preferences to use.
  final AppPreferences appPreferences;

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
          final distance = entry.distance;
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
                        credentials: widget.appPreferences.appCredentials!,
                      ),
                    );
                    setState(() {});
                  },
          );
        },
        itemCount: widget.stops.length,
      );
}
