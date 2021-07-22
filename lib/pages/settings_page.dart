import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  static String routeName = 'settings_page';
  static String settingsTitle = 'Settings';
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 234, 219, 1),
      body: SafeArea(
        child: Text('Settings Page'),
      ),
    );
  }
}
