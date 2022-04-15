import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../util.dart';
import '../../../http.dart';
import '../../../json/app_credentials.dart';
import '../../../json/gps_entries.dart';
import '../../../json/gps_entry.dart';
import '../../../widgets/center_text.dart';
import '../../../widgets/loading.dart';

/// A widget for showing nearby stops.
class NearbyStops extends StatefulWidget {
  /// Create an instance.
  const NearbyStops({
    required this.credentials,
    // ignore: prefer_final_parameters
    super.key,
  });

  /// The app credentials to use.
  final AppCredentials credentials;

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
              credentials: widget.credentials,
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
      return ListView.builder(
        itemBuilder: (final context, final index) {
          final entry = entries[index];
          final description = entry.description;
          var title = entry.name;
          if (description != null) {
            title = '$title ($description)';
          }
          return ListTile(
            autofocus: index == 0,
            title: Text(title),
            subtitle: Text(
              sensibleDistance(
                entry.distance ??
                    Geolocator.distanceBetween(
                      position.latitude,
                      position.longitude,
                      entry.latitude,
                      entry.longitude,
                    ),
              ),
            ),
            onTap: () {},
          );
        },
        itemCount: entries.length,
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
