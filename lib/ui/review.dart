import 'package:flutter/material.dart';
import 'package:keso/model/book.dart';

import 'common/book_cover.dart';
import 'common/book_title.dart';

class ReviewPage extends StatelessWidget {

  final Book book;
  ReviewPage({Key key, @required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // We overlap the image and the button by
          // creating a Stack object:
          Stack(
            children: <Widget>[
              BookCover(book.cover),
              /*Positioned(
                child: _buildFavoriteButton(),
                top: 2.0,
                right: 2.0,
              ),*/
            ],
          ),
          BookTitle(book, true),
          Review(book.review)
        ],
      ),
    );
  }
}


class Review extends StatelessWidget {

  final String review;
  Review(this.review);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Text(review)
    );
  }

}
