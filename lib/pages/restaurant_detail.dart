import 'package:dicoding_news_app/data/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/menu_card.dart';
import '../provider/restaurant_detail_provider.dart';
import '../widgets/platform_widget.dart';
import '../utils/restaurant_state.dart';
import '../utils/alert_dialog.dart';

class RestaurantDetail extends StatefulWidget {
  static final String routeName = 'restaurant_detail';
  final String id;
  RestaurantDetail({required this.id});

  @override
  _RestaurantDetailState createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  String imageUrl = 'https://restaurant-api.dicoding.dev/images/medium/';
  CollectionReference favorites =
      FirebaseFirestore.instance.collection('favorites');
  Widget _buildList() {
    return SafeArea(
      child: Consumer<RestaurantDetailProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.state == ResultState.HasData) {
            var restaurant = state.result.restaurant;
            var food = state.result.restaurant.menus.foods;
            var drinks = state.result.restaurant.menus.drinks;
            return Column(
              children: [
                Stack(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                          child: Image.network(
                            imageUrl + restaurant.pictureId,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: IconButton(
                            onPressed: () {
                              favorites.get().then((data) {
                                var found = false;
                                data.docs.forEach((element) {
                                  if (element['name'] == restaurant.name) {
                                    found = true;
                                  }
                                });
                                if (!found) {
                                  favorites.add({
                                    'id': restaurant.id,
                                    'name': restaurant.name,
                                    'description': restaurant.description,
                                    'rating': restaurant.rating,
                                    'city': restaurant.city,
                                    'createdAt': DateTime.now(),
                                    'pictureId': restaurant.pictureId,
                                  }).then((value) {
                                    print("Favorite Added");
                                    showAlertDialog(
                                      context,
                                      "Success",
                                      "Favorite successfully added!",
                                    );
                                  }).catchError((error) =>
                                      print("Failed to add user: $error"));
                                } else {
                                  showAlertDialog(
                                    context,
                                    "Error",
                                    "Favorite already added!",
                                  );
                                }
                              });
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        top: 10.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: IconButton(
                          constraints: BoxConstraints(
                            minWidth: 40.0,
                            minHeight: 40.0,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.restaurant_menu,
                              color: Colors.teal,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              restaurant.name,
                              style: TextStyle(
                                fontSize: 21.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.teal,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.place,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              restaurant.city + ', ' + restaurant.address,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'DESCRIPTION',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          restaurant.description,
                          style: TextStyle(
                            height: 1.3,
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'FOOD',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        MenuCard(
                          imageUrl: imageUrl,
                          pictureId: restaurant.pictureId,
                          menu: food,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'DRINKS',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        MenuCard(
                          imageUrl: imageUrl,
                          pictureId: restaurant.pictureId,
                          menu: drinks,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          } else if (state.state == ResultState.NoData) {
            return Center(
              child: Text(state.message),
            );
          } else if (state.state == ResultState.Error) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Center(
              child: Text(''),
            );
          }
        },
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(
        apiService: ApiService(),
        id: widget.id,
      ),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 241, 225, 1),
        body: _buildList(),
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(
        apiService: ApiService(),
        id: widget.id,
      ),
      child: CupertinoPageScaffold(
        backgroundColor: Color.fromRGBO(255, 241, 225, 1),
        child: _buildList(),
      ),
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
