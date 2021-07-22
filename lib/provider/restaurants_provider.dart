import 'dart:async';
import '../data/api/api_service.dart';
import '../data/model/restaurant.dart';
import 'package:flutter/material.dart';
import '../utils/restaurant_state.dart';

class RestaurantsProvider extends ChangeNotifier {
  final ApiService apiService;
  RestaurantsProvider({required this.apiService}) {
    _fetchRestaurants();
  }

  // RestaurantsList
  late dynamic _restaurantsResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  dynamic get result => _restaurantsResult;
  ResultState get state => _state;

  Future<dynamic> _fetchRestaurants() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurants = await apiService.fetchRestaurants();
      if (restaurants.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantsResult = restaurants;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> fetchRestaurantsQuery(str) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurants = await apiService.fetchRestaurantsQuery(str);
      if (restaurants.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantsResult = restaurants;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
