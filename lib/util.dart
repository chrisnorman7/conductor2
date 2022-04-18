import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

/// Kilometres.
const km = 1000;

/// Return the given distance in [metres] with sensible units.
String sensibleDistance(final double metres) {
  if (metres > km) {
    return '${(metres / km).floor()} km';
  } else {
    return '${metres.floor()} m';
  }
}

/// Get a dictionary of coordinates from the given [position].
Map<String, String> positionDict(final Position position) =>
    {'lat': position.latitude.toString(), 'lon': position.longitude.toString()};

/// Push a widget with the given [builder].
Future<void> pushWidget({
  required final BuildContext context,
  required final WidgetBuilder builder,
}) =>
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: builder),
    );
