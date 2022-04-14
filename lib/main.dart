import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'src/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

/// The main app class.
class MyApp extends StatelessWidget {
  /// Create an instance.
  const MyApp({
    // ignore: prefer_final_parameters
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(final BuildContext context) {
    RendererBinding.instance.setSemanticsEnabled(true);
    return MaterialApp(
      title: 'Conductor 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
