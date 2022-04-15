import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../json/app_preferences.dart';
import '../../../widgets/center_text.dart';
import '../../../widgets/stops_list.dart';

/// A widget for showing favourite transit stops.
class FavouriteStops extends StatefulWidget {
  /// Create an instance.
  const FavouriteStops({
    required this.preferences,
    required this.controller,
    required this.initialPosition,
    // ignore: prefer_final_parameters
    super.key,
  });

  /// The app preferences to use.
  final AppPreferences preferences;

  /// The location stream to listen to.
  final StreamController<Position> controller;

  /// The most recent position.
  final Position? initialPosition;

  /// Create state for this widget.
  @override
  FavouriteStopsState createState() => FavouriteStopsState();
}

/// State for [FavouriteStops].
class FavouriteStopsState extends State<FavouriteStops> {
  late final StreamSubscription<Position> _streamSubscription;
  Position? _position;

  /// Start listening for position changes.
  @override
  void initState() {
    super.initState();
    _streamSubscription = widget.controller.stream.listen(
      (final event) {
        final position = _position;
        if (position == null ||
            Geolocator.distanceBetween(
                  position.latitude,
                  position.longitude,
                  event.latitude,
                  event.longitude,
                ) >
                event.accuracy) {
          setState(() {
            _position = event;
          });
        }
      },
    );
  }

  /// Build a widget.
  @override
  Widget build(final BuildContext context) {
    final position = _position ?? widget.initialPosition;
    if (position == null) {
      return const CenterText(text: 'Getting current location...');
    }
    final stops = widget.preferences.favouriteTransitStops;
    if (stops.isEmpty) {
      return const CenterText(text: 'You have no favourite stops.');
    }
    return StopsList(
      stops: stops,
      appPreferences: widget.preferences,
    );
  }

  /// Cancel the stream.
  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }
}
