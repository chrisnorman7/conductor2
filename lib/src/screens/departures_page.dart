import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../http.dart';
import '../json/app_credentials.dart';
import '../transit_stops/bus_stop.dart';
import '../transit_stops/train_station.dart';
import '../transit_stops/tram_stop.dart';
import '../transit_stops/transit_stop.dart';
import '../transit_stops/tube_station.dart';
import '../widgets/center_text.dart';

/// A page for showing the given [stop].
class DeparturesPage extends StatefulWidget {
  /// Create an instance.
  const DeparturesPage({
    required this.stop,
    required this.credentials,
    // ignore: prefer_final_parameters
    super.key,
  });

  /// The stop to show departures for.
  final TransitStop stop;

  /// The app credentials to authenticate with.
  final AppCredentials credentials;

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
    return Scaffold(
      appBar: AppBar(
        title: Text(stop.name),
      ),
      body: CenterText(text: stop.name),
    );
  }

  /// Load the departures for this stop.
  Future<void> loadDepartures() async {
    final stop = widget.stop;
    final String url;
    if (stop is TrainStation || stop is TubeStation) {
      final String code;
      if (stop is TrainStation) {
        code = stop.code;
      } else {
        code = (stop as TubeStation).atcoCode;
      }
      url = 'train/station/$code/live.json';
    } else if (stop is BusStop || stop is TramStop) {
      final String code;
      if (stop is BusStop) {
        code = stop.atcoCode;
      } else {
        code = (stop as TramStop).atcoCode;
      }
      url = 'bus/stop/$code/live.json';
    } else {
      throw StateError('Cannot handle the transit stop $stop.');
    }
    final response = await get(
      credentials: widget.credentials,
      path: url,
    );
    File('departures.json').writeAsStringSync(
      const JsonEncoder.withIndent('  ').convert(response.data),
    );
  }
}
