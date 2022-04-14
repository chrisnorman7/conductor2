import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A list tile which allows the copying of its [subtitle].
class CopyListTile extends StatelessWidget {
  /// Create an instance.
  const CopyListTile({
    required this.title,
    required this.subtitle,
    this.autofocus = false,
    // ignore: prefer_final_parameters
    super.key,
  });

  /// The title of the resulting [ListTile].
  final String title;

  /// The subtitle for the resulting [ListTile].
  final String subtitle;

  /// Whether the resulting [ListTile] should be autofocused.
  final bool autofocus;

  /// Build the widget.
  @override
  Widget build(final BuildContext context) => ListTile(
        autofocus: autofocus,
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: () {
          final data = ClipboardData(text: '$title: $subtitle');
          Clipboard.setData(data);
        },
      );
}
