import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './pages/restaurant_page.dart';
import './pages/home_page.dart';
import './pages/settings_page.dart';
import './pages/restaurant_detail.dart';
import 'pages/favorites_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        RestaurantPage.routeName: (context) => RestaurantPage(),
        SettingsPage.routeName: (context) => SettingsPage(),
        RestaurantDetail.routeName: (context) => RestaurantDetail(
            id: ModalRoute.of(context)?.settings.arguments as String),
        FavoritesPage.routeName: (context) => FavoritesPage(),
      },
    );
  }
}
