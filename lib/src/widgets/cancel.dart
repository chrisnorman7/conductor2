import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A widget that can be cancelled with the escape key.
class Cancel extends StatelessWidget {
  /// Create an instance.
  const Cancel({
    required this.child,
    // ignore: prefer_final_parameters
    super.key,
  });

  /// The widget below this one in the tree.
  final Widget child;

  /// Build the widget.
  @override
  Widget build(final BuildContext context) => CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.escape): () =>
              Navigator.pop(context)
        },
        child: child,
      );
}
