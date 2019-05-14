import 'package:flutter/material.dart';
import 'package:keso/data/database.dart';
import 'package:keso/model/book.dart';
import 'package:keso/ui/common/book_cover.dart';

import 'common/book_title.dart';
import 'common/star_rating.dart';

class EditionPage extends StatelessWidget {
  final Book book;

  EditionPage({Key key, @required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Write a review'),
      ),
      body: Card(
        child: EditionForm(book: book),
      ),
    );
  }
}

// Create a Form Widget
class EditionForm extends StatefulWidget {
  final Book book;

  EditionForm({@required this.book}) : super();

  @override
  EditionFormState createState() {
    return EditionFormState(book: book);
  }
}

class EditionFormState extends State<EditionForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();

  final Book book;

  EditionFormState({@required this.book}) : super();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          BookCover(book.cover),
          BookTitle(book, false),
          FormField<int>(
            initialValue: book.rating,
            autovalidate: true,
            builder: (state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  StarRating(
                    onChanged: (val) => { state.didChange(val), book.rating = val },
                    value: state.value,
                  ),
                ],
              );
            },
          ),
          Text("Review"),
          TextFormField(
            initialValue: book.review,
            maxLines: null,
            minLines: 10,
            keyboardType: TextInputType.multiline,
            validator: (value) {
              book.review = value;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  BookDatabase.get().updateBook(book);
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Saved')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

