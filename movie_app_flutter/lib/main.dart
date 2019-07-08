import 'package:flutter/material.dart';
import 'package:movie_app_flutter/API/client.dart';
import 'package:movie_app_flutter/API/response.dart';
import 'package:movie_app_flutter/Builder/movie_list_builder.dart';
import 'package:movie_app_flutter/Widgets/DescriptionCard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Db',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'Movie Db'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  _MyHomePageState() {}

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: new FutureBuilder(future: MovieDbClient().fetch(),
            builder: (BuildContext context, AsyncSnapshot<Response> snapshot){
              if (!snapshot.hasData) {
                return new Center(
                child: new CircularProgressIndicator(),
                );
              }
              // Shows the real data with the data retrieved.
              Response response = snapshot.data;
              return new CustomScrollView(
                primary: false,
                slivers: <Widget>[
                  new SliverPadding(
                    padding: const EdgeInsets.all(10.0),
                    sliver: new SliverGrid.count(
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      crossAxisCount: 1,
                      children: ItemListBuilder.createItemCards(response, context),
                    ),
                  ),
                ],
              );
              },),
    );
  }
}
