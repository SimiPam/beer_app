import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'beer_model.dart';

class BeerViewModel extends ChangeNotifier {
  List<Beer> _beers = [];
  bool _isLoading = false;
  bool _hasError = false;
  int _page = 1;

  List<Beer> get beers => _beers;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchBeers() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(
          'https://api.punkapi.com/v2/beers?page=$_page&per_page=10'));
      if (response.statusCode == 200) {
        final List<dynamic> beerData = json.decode(response.body);
        if (beerData.isEmpty) {
          _isLoading = false;
          _hasError = false;
          notifyListeners();
        } else {
          _beers.addAll(beerData.map((json) => Beer.fromJson(json)).toList());
          _page++;
          _isLoading = false;
          _hasError = false;
          notifyListeners();
        }
      } else {
        _isLoading = false;
        _hasError = true;
        notifyListeners();
      }
    } catch (e) {
      _isLoading = false;
      _hasError = true;
      notifyListeners();
    }
  }

  Future<void> retry() async {
    _hasError = false;
    await fetchBeers();
  }

  Future<void> loadMoreItems() async {
    if (!_isLoading) {
      await fetchBeers();
    }
  }
}
