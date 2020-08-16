import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sharedprefs/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_sharedprefs/settings.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Settings _settings = Settings.initial();

  void _saveSettings() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var settingsString = json.encode(_settings.toJson());
    await preferences.setString(
        Constants.SETTINGS_SHAREDPREF_KEY, settingsString);

    debugPrint("[SAVE PREFS] - $_settings");
  }

  Future<void> loadSettingsFromPrefs() async {
    Settings settings = Settings.initial();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var stateString = preferences.getString(Constants.SETTINGS_SHAREDPREF_KEY);
    if (stateString != null) {
      dynamic prefs = json.decode(stateString);
      settings = settings.copyWith(
          fontSize: prefs["fontSize"],
          isBold: prefs["isBold"],
          isItalics: prefs["isItalics"]);
      debugPrint("[LOAD PREFS] - $settings");
    }

    setState(() {
      debugPrint("[SETSTATE] - $settings");
      _settings = settings;
      _saveSettings();
    });
  }

  @override
  void initState() {
    super.initState();
    loadSettingsFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("[BUILD] - MyHomePage");

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: [
                  Text("Font Size"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Slider(
                        min: 10,
                        max: 40,
                        value: _settings.fontSize,
                        onChanged: (value) {
                          setState(() {
                            debugPrint("[SETSTATE] - _fontSize to $value");
                            _settings = _settings.copyWith(fontSize: value);
                            _saveSettings();
                          });
                        }),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Bold"),
                  Checkbox(
                      value: _settings.isBold,
                      onChanged: (value) {
                        setState(() {
                          debugPrint("[SETSTATE] - _isBold to $value");
                          _settings = _settings.copyWith(isBold: value);
                          _saveSettings();
                        });
                      }),
                ],
              ),
              Row(
                children: [
                  Text("Italics"),
                  Checkbox(
                      value: _settings.isItalics,
                      onChanged: (value) {
                        setState(() {
                          debugPrint("[SETSTATE] - _isItalic to $value");
                          _settings = _settings.copyWith(isItalics: value);
                          _saveSettings();
                        });
                      }),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 300,
                  child: Text(
                    'Flutter Shared Preferences Example, ' +
                        'Shared Preferences can be used to persist data. ' +
                        'Typical use case would be to store app settings',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: _settings.fontSize,
                        fontWeight: _settings.isBold
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontStyle: _settings.isItalics
                            ? FontStyle.italic
                            : FontStyle.normal),
                  ),
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
