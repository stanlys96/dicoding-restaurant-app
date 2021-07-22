import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/model/restaurant.dart';
import '../components/restaurant_card.dart';
import '../widgets/platform_widget.dart';
import '../utils/alert_dialog.dart';

class FavoritesPage extends StatefulWidget {
  static String routeName = 'favorites_page';
  static String favoriteTitle = 'Favorites';

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Widget _buildList(context) {
    var favorites = _firestore.collection('favorites');
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 13.0,
          right: 13.0,
          top: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Your favorite restaurants...',
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('favorites')
                    .orderBy('createdAt')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var data = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var restaurant = Restaurant.fromJson(data[index]);
                      return Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          RestaurantCard(
                            restaurant: restaurant,
                          ),
                          IconButton(
                            onPressed: () {
                              twoButtonsDialog(context, () {
                                favorites.get().then((value) {
                                  value.docs.forEach((document) {
                                    if (document['name'] == restaurant.name) {
                                      document.reference.delete();
                                    }
                                  });
                                });
                                Navigator.pop(context);
                              });
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 241, 225, 1),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color.fromRGBO(255, 241, 225, 1),
      child: _buildList(context),
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
