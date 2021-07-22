import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/platform_widget.dart';
import '../components/restaurant_card.dart';
import '../provider/restaurants_provider.dart';
import '../utils/restaurant_state.dart';

class RestaurantPage extends StatelessWidget {
  static String routeName = 'restaurant_page';

  Widget _buildList(context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(
          left: 13.0,
          right: 13.0,
          top: 20.0,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  20.0,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(
                    width: 7.0,
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: (val) {
                        Provider.of<RestaurantsProvider>(context, listen: false)
                            .fetchRestaurantsQuery(val);
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'Restaurant 1',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Recommended restaurants for you...',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            Expanded(child: Consumer<RestaurantsProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.state == ResultState.HasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.result.restaurants.length,
                    itemBuilder: (context, index) {
                      var restaurant = state.result.restaurants[index];
                      return RestaurantCard(restaurant: restaurant);
                    },
                  );
                } else if (state.state == ResultState.NoData) {
                  return Center(child: Text(state.message));
                } else if (state.state == ResultState.Error) {
                  return Center(child: Text(state.message));
                } else {
                  return Center(
                    child: Text(''),
                  );
                }
              },
            ))
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
