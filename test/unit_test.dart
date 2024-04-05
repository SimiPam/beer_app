import 'dart:convert';

import 'package:beer_app/beer_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  const url = 'https://api.punkapi.com/v2/beers?page=2&per_page=10';
  group('BeerViewModel Tests', () {
    test('fetchBeers - Successful Response', () async {
      final client = MockClient();
      final viewModel = BeerViewModel();

      when(client.get(Uri.parse(url))).thenAnswer((_) async => http.Response(
          json.encode([
            {
              "name": "Beer 1",
              "tagline": "Tagline 1",
              "first_brewed": "01/2020",
              "description": "Description 1"
            }
          ]),
          200));

      await viewModel.fetchBeers();

      expect(viewModel.isLoading, false);
      expect(viewModel.hasError, false);
      expect(viewModel.beers.length,
          1); // Assuming the API returns one beer in this case
    });
  });

  test('fetchBeers - Error Response', () async {
    final client = MockClient();
    final viewModel = BeerViewModel();

    when(client.get(Uri.parse(url)))
        .thenAnswer((_) async => http.Response('Error', 404));

    await viewModel.fetchBeers();

    expect(viewModel.isLoading, false);
    expect(viewModel.hasError, true);
    expect(viewModel.beers.length, 0);
  });

  test('retry', () async {
    final client = MockClient();
    final viewModel = BeerViewModel();

    when(client.get(Uri.parse(url))).thenAnswer((_) async => http.Response(
        json.encode([
          {
            "name": "Beer 1",
            "tagline": "Tagline 1",
            "first_brewed": "01/2020",
            "description": "Description 1"
          }
        ]),
        200));

    await viewModel.retry();

    expect(viewModel.isLoading, false);
    expect(viewModel.hasError, false);
    // Depending on the implementation, you may check other properties or behaviors after retry
  });

  test('loadMoreItems', () async {
    final client = MockClient();
    final viewModel = BeerViewModel();

    when(client.get(Uri.parse(url))).thenAnswer((_) async => http.Response(
        json.encode([
          {
            "name": "Beer 2",
            "tagline": "Tagline 2",
            "first_brewed": "02/2020",
            "description": "Description 2"
          }
        ]),
        200));

    await viewModel.loadMoreItems();

    // Verify the expected changes in ViewModel properties
    expect(viewModel.isLoading, false);
    expect(viewModel.hasError, false);
    expect(viewModel.beers.length,
        1); // Assuming the API returns one beer in this case
  });
}
