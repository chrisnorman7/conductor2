import 'package:flutter/material.dart';

import '../json/app_preferences.dart';

/// A widget to view a list of.
class StopsList extends StatelessWidget {
  /// Create an instance.
  const StopsList({
    required this.appPreferences,
    // ignore: prefer_final_parameters
    super.key,
  });

  /// The app preferences to use.
  final AppPreferences appPreferences;

  /// Build the widget.
  @override
  Widget build(final BuildContext context) => const Center(
        child: Text('Working.'),
      );
}
