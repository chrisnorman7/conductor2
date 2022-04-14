import 'package:flutter/material.dart';

/// A widget that shows the given [error].
class ErrorPage extends StatelessWidget {
  /// Create an instance.
  const ErrorPage({
    required this.error,
    this.title = 'Error',
    this.actions = const [],
    this.floatingActionButton,
    // ignore: prefer_final_parameters
    super.key,
  });

  /// The error string to show.
  final String error;

  /// The title of the resulting [Scaffold].
  final String title;

  /// The actions to use.
  final List<Widget> actions;

  /// The floating action button to use.
  final FloatingActionButton? floatingActionButton;

  /// Build the widget.
  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: actions,
          title: Text(title),
        ),
        body: Focus(
          autofocus: true,
          child: Text(error),
        ),
        floatingActionButton: floatingActionButton,
      );
}
