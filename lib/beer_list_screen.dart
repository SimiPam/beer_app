import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'beer_details_screen.dart';
import 'beer_viewmodel.dart';

class BeerListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beer List'),
      ),
      body: Consumer<BeerViewModel>(
        builder: (context, model, _) {
          if (model.isLoading && model.beers.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else if (model.beers.isEmpty && model.hasError) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Something went wrong while fetching data!'),
                  action: SnackBarAction(
                    label: 'Retry',
                    onPressed: model.retry,
                  ),
                ),
              );
            });

            return Container();
          } else {
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
                  model.loadMoreItems();
                }
                return true;
              },
              child: ListView.builder(
                itemCount: model.beers.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == model.beers.length) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    final beer = model.beers[index];
                    return ListTile(
                      title: Text(beer.name),
                      subtitle: Text(beer.tagline),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BeerDetailPage(beer: beer),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}
