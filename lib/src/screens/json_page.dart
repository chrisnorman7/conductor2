import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../util.dart';
import '../widgets/cancel.dart';
import '../widgets/center_text.dart';

/// A widget that shows JSON.
class JsonPage extends StatelessWidget {
  /// Create an instance.
  const JsonPage({
    required this.json,
    // ignore: prefer_final_parameters
    super.key,
  });

  /// The JSON to show.
  final Map<String, dynamic> json;

  /// Build the widget.
  @override
  Widget build(final BuildContext context) {
    final entries = json.entries.toList();
    final Widget child;
    if (entries.isEmpty) {
      child = const CenterText(text: 'No data to show.');
    } else {
      child = ListView.builder(
        itemBuilder: (final context, final index) {
          final entry = entries[index];
          final key = entry.key;
          final dynamic value = entry.value;
          return ListTile(
            autofocus: index == 0,
            title: Text(key),
            subtitle: Text(value.toString()),
            onTap: () {
              final Map<String, dynamic> subJson;
              if (value is List) {
                subJson = <String, dynamic>{
                  for (var i = 0; i < value.length; i++) i.toString(): value[i]
                };
              } else if (value is Map) {
                subJson = <String, dynamic>{
                  for (final key in value.keys) key.toString(): value[key]
                };
              } else {
                Clipboard.setData(ClipboardData(text: '$key = "$value"'));
                return;
              }
              pushWidget(
                context: context,
                builder: (final context) => JsonPage(json: subJson),
              );
            },
          );
        },
        itemCount: entries.length,
      );
    }
    return Cancel(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('JSON View'),
        ),
        body: child,
      ),
    );
  }
}
