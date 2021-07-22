import 'dart:async';
import 'package:flutter/material.dart';
import '../data/api/api_service.dart';
import '../data/model/restaurant_detail.dart';
import '../utils/restaurant_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;
  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchRestaurantDetail(id);
  }

  // RestaurantsList
  late RestaurantDetailResult _restaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  RestaurantDetailResult get result => _restaurantResult;
  ResultState get state => _state;

  Future<dynamic> _fetchRestaurantDetail(id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.fetchRestaurantDetail(id);
      if (restaurant.restaurant.id == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
