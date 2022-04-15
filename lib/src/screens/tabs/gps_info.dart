import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../util.dart';
import '../../widgets/copy_list_tile.dart';
import '../../widgets/loading.dart';

/// A widget for showing GPS information.
class GpsInfo extends StatefulWidget {
  /// Create an instance.
  const GpsInfo({
    required this.controller,
    required this.initialPosition,
    // ignore: prefer_final_parameters
    super.key,
  });

  /// The stream controller to use.
  final StreamController<Position> controller;

  /// The initial position.
  final Position? initialPosition;

  /// Create state for this widget.
  @override
  GpsInfoState createState() => GpsInfoState();
}

/// State for [GpsInfo].
class GpsInfoState extends State<GpsInfo> {
  late final StreamSubscription<Position> _streamSubscription;
  Position? _position;

  /// Start listening for location changes.
  @override
  void initState() {
    super.initState();
    _streamSubscription = widget.controller.stream.listen(
      (final event) => setState(
        () => _position = event,
      ),
    );
  }

  /// Build a widget.
  @override
  Widget build(final BuildContext context) {
    final position = _position ?? widget.initialPosition;
    if (position == null) {
      return const Loading();
    } else {
      return ListView(
        children: [
          CopyListTile(
            title: 'Latitude',
            subtitle: '${position.latitude}',
            autofocus: true,
          ),
          CopyListTile(title: 'Longitude', subtitle: '${position.longitude}'),
          CopyListTile(
            title: 'Altitude',
            subtitle: sensibleDistance(position.altitude),
          ),
          CopyListTile(
            title: 'Speed',
            subtitle: position.speed.isNaN
                ? 'Unknown'
                : '${sensibleDistance(position.speed)}/s',
          ),
          CopyListTile(
            title: 'Accuracy',
            subtitle: sensibleDistance(position.accuracy),
          ),
          CopyListTile(
            title: 'Speed Accuracy',
            subtitle: '${sensibleDistance(position.speedAccuracy)}/s',
          ),
          CopyListTile(
            title: 'Floor',
            subtitle: position.floor == null ? 'Unknown' : '${position.floor}',
          )
        ],
      );
    }
  }

  /// Stop listening for location changes.
  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }
}
