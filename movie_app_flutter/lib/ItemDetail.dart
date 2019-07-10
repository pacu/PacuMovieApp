import 'package:flutter/material.dart';

import 'API/item.dart';

class ItemDetailPage extends StatelessWidget {
  final Item item;
  ItemDetailPage(this.item);
  
  @override
  Widget build(BuildContext context) {
    var backdropImagePath = "https://image.tmdb.org/t/p/w500/" + item.backdropPath;
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: ListView (
        children: <Widget>[
          Row(children: <Widget>[
            new Image.network(backdropImagePath, fit: BoxFit.cover),
          ],),
          Row(children: <Widget>[
            Text(item.title, 
                  style: TextStyle(fontWeight: FontWeight.w500,
                                  color: Colors.white),
            ),
            
          ],)

        ],)
    );
  }
}