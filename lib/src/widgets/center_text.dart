import 'package:flutter/material.dart';

/// A widget that shows [text] in the centre of the screen.
class CenterText extends StatelessWidget {
  /// Create an instance.
  const CenterText({
    required this.text,
    this.autofocus = true,
    // ignore: prefer_final_parameters
    super.key,
  });

  /// The text to show.
  final String text;

  /// Whether the resulting [Focus] should be autofocused.
  final bool autofocus;

  /// GBuild the widget.
  @override
  Widget build(final BuildContext context) => Focus(
        autofocus: autofocus,
        child: Text(text),
      );
}
