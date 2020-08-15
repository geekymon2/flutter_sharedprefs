import 'package:flutter/material.dart';
import 'package:flutter_sharedprefs/settingspage.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Preferences Tutorial',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SettingsPage(title: 'Settings'),
    );
  }
}
