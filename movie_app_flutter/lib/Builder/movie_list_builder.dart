

import 'package:flutter/material.dart';
import 'package:movie_app_flutter/API/item.dart';
import 'package:movie_app_flutter/API/response.dart';
import 'package:movie_app_flutter/Widgets/Gauge.dart';

import '../ItemDetail.dart';
class ItemListBuilder {
 
  static List<Widget> createItemCards(Response response, BuildContext context) {
  // Children list for the list.
  List<Widget> listElementWidgetList = new List<Widget>();
  if (response.results != null) {
    var results = response.results;
    var lengthOfList = results.length;
    for (int i = 0; i < lengthOfList; i++) {
      Item item = results[i];
      double rating = (item.voteAverage / 10);
      // Image URL
      var imageURL = "https://image.tmdb.org/t/p/w500/" + item.posterPath;
      // List item created with an image of the poster
      var listItem = new GridTile(
          footer: new GridTileBar(
            backgroundColor: Colors.black45,
            title: new Text(item.title),
            trailing: Container(
              height: 100, 
              width: 100,
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
              child: 
                 GaugeChart.withRating(rating),
              ),
          ),
          child: new GestureDetector(
            onTap: () {
               Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ItemDetailPage(item)),
            );
            },
            child: new Image.network(imageURL, fit: BoxFit.cover),
          )
      );
      listElementWidgetList.add(listItem);
    }
  }
  return listElementWidgetList;
}
}