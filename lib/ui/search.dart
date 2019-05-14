import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:keso/model/author.dart';

import 'package:keso/model/book.dart';
import 'package:keso/ui/edition.dart';

class SearchPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Write a review'),
      ),
      body: Card(
        child: SearchForm(),
      ),
    );
  }
}

class SearchForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              autofocus: true,
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(fontStyle: FontStyle.italic),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'What are you looking for?'),
            ),
            suggestionsCallback: (pattern) async {
              return await _fetchBooks(pattern);
            },
            itemBuilder: (context, Book book) {
              print("$context, $book");
              return ListTile(
                leading: book.cover != null ? Image.network(book.cover) : Icon(Icons.book),
                title: Text(book.title),
                subtitle: Text(book.author.name),
              );
            },
            onSuggestionSelected: (suggestion) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditionPage(book: suggestion)));
            },
          ),
        ],
      ),
    );
  }

  Future<List<Book>> _fetchBooks(String query) async {
    final uri = Uri.https('www.googleapis.com', '/books/v1/volumes', { 'q': query });
    print("Autocomplete $uri");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      var results = json.decode(response.body)['items'];
      List<Book> books = List();

      if(results != null) {
        results.forEach((book) => books.add(Book.fromJson(book)));
      }

      return books;

    } else {
      throw Exception('Failed to load post');
    }
  }

}
