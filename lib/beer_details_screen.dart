import 'package:flutter/material.dart';

import 'beer_model.dart';

class BeerDetailPage extends StatelessWidget {
  final Beer beer;

  const BeerDetailPage({Key? key, required this.beer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(beer.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${beer.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Tagline: ${beer.tagline}'),
            SizedBox(height: 8),
            Text('First Brewed: ${beer.firstBrewed}'),
            SizedBox(height: 8),
            Text('Description: ${beer.description}'),
          ],
        ),
      ),
    );
  }
}
