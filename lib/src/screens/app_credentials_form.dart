import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../json/app_credentials.dart';

String? _validator(final String? value) {
  if (value == null || value.isEmpty) {
    return 'You must provide a value';
  }
  return null;
}

const _applicationsUrl =
    'https://developer.transportapi.com/admin/applications/';

/// A form for getting app credentials.
class AppCredentialsForm extends StatefulWidget {
  /// Create an instance.
  const AppCredentialsForm({
    required this.onDone,
    // ignore: prefer_final_parameters
    super.key,
  });

  /// What to do with the resulting app credentials.
  final ValueChanged<AppCredentials> onDone;

  /// Create state for this widget.
  @override
  AppCredentialsFormState createState() => AppCredentialsFormState();
}

/// State for [AppCredentialsForm].
class AppCredentialsFormState extends State<AppCredentialsForm> {
  late final GlobalKey<FormState> _formKey;

  /// The app ID controller.
  late final TextEditingController appIdController;

  /// The app key controller.
  late final TextEditingController appKeyController;

  /// Initialise the controllers.
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();
    appIdController = TextEditingController();
    appKeyController = TextEditingController();
  }

  /// Build a widget.
  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [
            ElevatedButton(
              onPressed: () => launch(_applicationsUrl),
              child: const Icon(
                Icons.open_in_browser,
                semanticLabel: 'Open $_applicationsUrl in browser',
              ),
            )
          ],
          title: const Text('App Credentials'),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                autofocus: true,
                controller: appIdController,
                decoration: const InputDecoration(
                  hintText: 'The app ID from $_applicationsUrl',
                  labelText: 'App ID',
                ),
                validator: _validator,
              ),
              TextFormField(
                controller: appKeyController,
                decoration: const InputDecoration(
                  hintText: 'The app key from $_applicationsUrl',
                  labelText: 'App Key',
                ),
                validator: _validator,
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              final appId = appIdController.text;
              final appKey = appKeyController.text;
              final credentials = AppCredentials(id: appId, key: appKey);
              widget.onDone(credentials);
            }
          },
          tooltip: 'Save',
          child: const Icon(Icons.save),
        ),
      );

  /// Dispose of controllers.
  @override
  void dispose() {
    super.dispose();
    appIdController.dispose();
    appKeyController.dispose();
  }
}
