import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../json/app_preferences.dart';
import '../widgets/loading.dart';
import 'app_credentials_form.dart';
import 'error_page.dart';
import 'main_page.dart';

/// The home page to use.
class HomePage extends StatefulWidget {
  /// Create an instance.
  const HomePage({
    // ignore: prefer_final_parameters
    super.key,
  });

  /// Create state for this widget.
  @override
  HomePageState createState() => HomePageState();
}

/// State for [HomePage].
class HomePageState extends State<HomePage> {
  AppPreferences? _appPreferences;
  bool? _serviceEnabled;
  LocationPermission? _locationPermission;

  /// Build a widget.
  @override
  Widget build(final BuildContext context) {
    final appPreferences = _appPreferences;
    final appCredentials = appPreferences?.appCredentials;
    final serviceEnabled = _serviceEnabled;
    final locationPermission = _locationPermission;
    if (appPreferences == null) {
      loadPreferences();
      return const LoadingScaffold(
        loadingMessage: 'Loading app preferences...',
      );
    } else if (serviceEnabled == null) {
      checkService();
      return const LoadingScaffold(
        loadingMessage: 'Checking location service...',
      );
    } else if (serviceEnabled == false) {
      return ErrorPage(
        error: 'The location service is disabled.',
        actions: [refreshButton],
      );
    } else if (locationPermission == null) {
      checkLocationPermission();
      return const LoadingScaffold(
        loadingMessage: 'Checking location permission...',
      );
    } else if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.deniedForever) {
      return ErrorPage(
        error: 'This app cannot function without location permissions.',
        actions: [refreshButton],
      );
    } else if (appCredentials == null) {
      return AppCredentialsForm(
        onDone: (final value) {
          appPreferences
            ..appCredentials = value
            ..save();
          setState(() {});
        },
      );
    } else {
      return MainPage(
        appPreferences: appPreferences,
        clearCredentials: () => setState(
          () => appPreferences
            ..appCredentials = null
            ..save(),
        ),
      );
    }
  }

  /// Get a refresh button.
  ElevatedButton get refreshButton => ElevatedButton(
        onPressed: () => setState(
          () {
            _appPreferences = null;
            _serviceEnabled = null;
            _locationPermission = null;
          },
        ),
        child: const Icon(
          Icons.refresh,
          semanticLabel: 'Refresh',
        ),
      );

  /// Load the app preferences.
  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(AppPreferences.preferencesKey);
    final AppPreferences appPreferences;
    if (data == null) {
      appPreferences = AppPreferences();
    } else {
      final json = jsonDecode(data) as Map<String, dynamic>;
      appPreferences = AppPreferences.fromJson(json);
    }
    setState(() => _appPreferences = appPreferences);
  }

  /// Check whether the location service is enabled.
  Future<void> checkService() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    setState(() => _serviceEnabled = serviceEnabled);
  }

  /// Check the location permission.
  Future<void> checkLocationPermission() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    setState(() => _locationPermission = permission);
  }
}
