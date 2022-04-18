import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../util.dart';
import '../../../http.dart';
import '../../../json/app_preferences.dart';
import '../../../json/gps_entries.dart';
import '../../../json/gps_entry.dart';
import '../../../json/transit_stops/transit_stop.dart';
import '../../../widgets/center_text.dart';
import '../../../widgets/loading.dart';
import '../../../widgets/stops_list.dart';

/// A widget for showing nearby stops.
class NearbyStops extends StatefulWidget {
  /// Create an instance.
  const NearbyStops({
    required this.preferences,
    required this.controller,
    required this.initialPosition,
    required this.gpsEntries,
    required this.cachePositions,
    // ignore: prefer_final_parameters
    super.key,
  });

  /// The app preferences to use.
  final AppPreferences preferences;

  /// The stream of location events to listen to.
  final StreamController<Position> controller;

  /// The most recent position.
  final Position? initialPosition;

  /// The cache of gps entries.
  final GpsEntries? gpsEntries;

  /// A method for caching GPS positions.
  final ValueChanged<GpsEntries> cachePositions;

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
    _streamSubscription = widget.controller.stream.listen(
      (final event) async {
        final position = _position;
        if (position == null ||
            Geolocator.distanceBetween(
                  position.latitude,
                  position.longitude,
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
            final gpsEntries = GpsEntries.fromJson(data);
            _entries = gpsEntries;
            widget.cachePositions(gpsEntries);
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
    final position = _position ?? widget.initialPosition;
    if (position == null) {
      return const Loading(
        loadingMessage: 'Getting current location...',
      );
    }
    final error = _error;
    if (error != null) {
      return CenterText(text: error);
    }
    final gpsEntries = _entries ?? widget.gpsEntries;
    if (gpsEntries == null) {
      return const Loading(
        loadingMessage: 'Getting nearby stops...',
      );
    } else if (gpsEntries.entries.isEmpty) {
      return const CenterText(
        text: 'There are no stops to show.',
      );
    } else {
      final entries = gpsEntries.entries
          .where((final element) => element.type != EntryType.postcode)
          .map<TransitStop>(
        (final e) {
          switch (e.type) {
            case EntryType.postcode:
              return e.toPostcode();
            case EntryType.busStop:
              return e.toBusStop();
            case EntryType.tubeStation:
              return e.toTubeStation();
            case EntryType.tramStop:
              return e.toTramStop();
            case EntryType.trainStation:
              return e.toTrainStation();
          }
        },
      ).toList();
      return StopsList(
        stops: entries,
        appPreferences: widget.preferences,
        position: position,
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
