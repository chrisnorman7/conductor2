import 'package:flutter/material.dart';

/// A widgets that shows a loading message.
class Loading extends StatelessWidget {
  /// Create an instance.
  const Loading({
    this.loadingMessage = 'Loading...',
    // ignore: prefer_final_parameters
    super.key,
  });

  /// The loading message.
  final String loadingMessage;

  /// Build the widget.
  @override
  Widget build(final BuildContext context) => Center(
        child: Focus(
          child: CircularProgressIndicator(semanticsLabel: loadingMessage),
        ),
      );
}

/// A [Loading] widget with a [Scaffold].
class LoadingScaffold extends StatelessWidget {
  /// Create an instance.
  const LoadingScaffold({
    this.title = 'Loading',
    this.loadingMessage = 'Loading...',
    // ignore: prefer_final_parameters
    super.key,
  });

  /// The title for the resulting [Scaffold].
  final String title;

  /// The loading message to use.
  final String loadingMessage;

  /// Build the widget.
  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Loading(loadingMessage: loadingMessage),
      );
}
