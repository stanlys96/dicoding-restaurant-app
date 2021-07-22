import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../widgets/platform_widget.dart';
import './restaurant_page.dart';
import './favorites_page.dart';
import './settings_page.dart';
import '../data/api/api_service.dart';
import '../provider/restaurants_provider.dart';

class HomePage extends StatefulWidget {
  static String routeName = 'home_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  static const String _headlineText = 'Main';

  List<Widget> _listWidget = [
    ChangeNotifierProvider<RestaurantsProvider>(
        create: (_) => RestaurantsProvider(apiService: ApiService()),
        child: RestaurantPage()),
    FavoritesPage(),
    SettingsPage(),
  ];

  List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.flame : Icons.restaurant),
        label: _headlineText),
    BottomNavigationBarItem(
        icon: Icon(
            Platform.isIOS ? CupertinoIcons.square_favorites : Icons.favorite),
        label: FavoritesPage.favoriteTitle),
    BottomNavigationBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
        label: SettingsPage.settingsTitle)
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _bottomNavBarItems,
      ),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
