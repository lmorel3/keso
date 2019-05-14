import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:keso/data/database.dart';
import 'package:keso/ui/review.dart';
import 'package:keso/ui/search.dart';

import 'model/author.dart';
import 'model/book.dart';
import 'ui/edition.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keso',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: MyHomePage(title: 'Keso'),
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

  void _openEdition(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
      future: BookDatabase.get().getBooks(),
      builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
        print(context); print(snapshot);
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new Text('loading...');
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return createListView(context, snapshot);
        }
      },
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home Page"),
      ),
      body: futureBuilder,
      floatingActionButton: FloatingActionButton(
        onPressed: () { _openEdition(context); },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
    List<Book> values = snapshot.data;
    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return Center(
            child: BookItem(book: values[index])
        );
      },
    );
  }

}

class BookItem extends StatelessWidget {
  const BookItem({Key key, this.book}) : super(key: key);
  final Book book;

  void _openReview(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReviewPage(book: this.book)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle = Theme.of(context).textTheme.body1;
    final TextStyle authorStyle = Theme.of(context).textTheme.caption;
    return InkWell(
        onTap: () { _openReview(context); },
        child: Center(child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.network(book.cover, height:80.0),
              Text(book.title, style: titleStyle),
              Text(book.author.name, style: authorStyle),
            ]
        ))
    );
  }
}
