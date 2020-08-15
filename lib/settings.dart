import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  Settings({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  double _fontSize = 10;
  bool _isBold = false;
  bool _isItalic = false;

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
                        value: _fontSize,
                        onChanged: (value) {
                          setState(() {
                            debugPrint("[SETSTATE] - _fontSize to $value");
                            _fontSize = value;
                          });
                        }),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Bold"),
                  Checkbox(
                      value: _isBold,
                      onChanged: (value) {
                        setState(() {
                          debugPrint("[SETSTATE] - _isBold to $value");
                          _isBold = value;
                        });
                      }),
                ],
              ),
              Row(
                children: [
                  Text("Italics"),
                  Checkbox(
                      value: _isItalic,
                      onChanged: (value) {
                        setState(() {
                          debugPrint("[SETSTATE] - _isItalic to $value");
                          _isItalic = value;
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
                        fontSize: _fontSize,
                        fontWeight:
                            _isBold ? FontWeight.bold : FontWeight.normal,
                        fontStyle:
                            _isItalic ? FontStyle.italic : FontStyle.normal),
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
