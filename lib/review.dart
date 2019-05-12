import 'package:flutter/material.dart';
import 'package:keso/model/book.dart';

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
          BookTitle(book, 15),
          Review(book.review)
        ],
      ),
    );
  }
}

class BookCover extends StatelessWidget {
  final String url;

  BookCover(this.url);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: Image.network(
        url.replaceFirst('zoom=5', 'zoom=10'),
        fit: BoxFit.cover,
      ),
    );
  }
}

class BookTitle extends StatelessWidget {
  final Book book;
  final double padding;

  BookTitle(this.book, this.padding);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        // Default value for crossAxisAlignment is CrossAxisAlignment.center.
        // We want to align title and description of recipes left:
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            book.title,
            style: Theme.of(context).textTheme.title,
          ),
          Text(
            book.author.name,
            style: Theme.of(context).textTheme.subtitle,
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Icon(Icons.star_half, size: 20.0),
              SizedBox(width: 5.0),
              Text(
                "${book.rating}/5",
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          )
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
