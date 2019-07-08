
import 'package:flutter/material.dart';
import 'package:movie_app_flutter/API/item.dart';
class DescriptionCard extends StatelessWidget {

    final Item item;
    DescriptionCard(this.item);
    @override 
    Widget build(BuildContext context) {
      return Text(item.title);
    }
}