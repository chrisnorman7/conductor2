import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../util.dart';
import '../../../http.dart';
import '../../../json/app_preferences.dart';
import '../../../json/gps_entries.dart';
import '../../../json/gps_entry.dart';
import '../../../widgets/center_text.dart';
import '../../../widgets/loading.dart';
import '../../../widgets/stops_list.dart';

/// A widget for showing nearby stops.
class NearbyStops extends StatefulWidget {
  /// Create an instance.
  const NearbyStops({
    required this.preferences,
    // ignore: prefer_final_parameters
    super.key,
  });

  /// The app preferences to use.
  final AppPreferences preferences;

  /// Create state for this widget.
  @override
  NearbyStopsState createState() => NearbyStopsState();
}

/// State for [NearbyStops].
class NearbyStopsState extends State<NearbyStops> {
  late final StreamSubscription<Position> _streamSubscription;
  Position? _position;
  GpsEntries? _entries;
  String? _error;

  /// Start listening.
  @override
  void initState() {
    super.initState();
    _streamSubscription = Geolocator.getPositionStream().listen(
      (final event) async {
        final oldPosition = _position;
        if (oldPosition == null ||
            Geolocator.distanceBetween(
                  oldPosition.latitude,
                  oldPosition.longitude,
                  event.latitude,
                  event.longitude,
                ) >
                event.accuracy) {
          _position = event;
          try {
            final response = await get(
              credentials: widget.preferences.appCredentials!,
              path: 'places.json',
              params: positionDict(event),
            );
            final data = response.data;
            if (data == null) {
              throw StateError('Empty data.');
            }
            _entries = GpsEntries.fromJson(data);
            setState(() {});
          } on Exception catch (e, s) {
            setState(
              () {
                _error = '$e\n$s';
              },
            );
          }
        }
      },
    );
  }

  /// Build a widget.
  @override
  Widget build(final BuildContext context) {
    final position = _position;
    if (position == null) {
      return const Loading(
        loadingMessage: 'Getting current location...',
      );
    }
    final error = _error;
    if (error != null) {
      return CenterText(text: error);
    }
    final gpsEntries = _entries;
    if (gpsEntries == null) {
      return const Loading(
        loadingMessage: 'Waiting for nearby points...',
      );
    } else if (gpsEntries.entries.isEmpty) {
      return const CenterText(
        text: 'There are no stops to show.',
      );
    } else {
      final entries = gpsEntries.entries
          .where((final element) => element.type != EntryType.postcode)
          .toList();
      return StopsList(
        stops: entries,
        appPreferences: widget.preferences,
      );
    }
  }

  /// Stop listening to the stream.
  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }
}
