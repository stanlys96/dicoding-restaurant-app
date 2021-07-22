import '../model/restaurant.dart';
import '../model/restaurant_detail.dart';
import '../model/restaurant_query.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantsResult> fetchRestaurants() async {
    final response = await http.get(Uri.parse(_baseUrl + '/list'));
    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  Future<RestaurantsQueryResult> fetchRestaurantsQuery(str) async {
    final response = await http.get(Uri.parse(_baseUrl + '/search?q=$str'));
    if (response.statusCode == 200) {
      return RestaurantsQueryResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurants query!');
    }
  }

  Future<RestaurantDetailResult> fetchRestaurantDetail(id) async {
    final response = await http.get(Uri.parse(_baseUrl + '/detail/$id'));
    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }
}
