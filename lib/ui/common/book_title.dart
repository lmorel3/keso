import 'package:flutter/material.dart';
import 'package:keso/model/book.dart';
import 'package:keso/ui/common/star_rating.dart';

class BookTitle extends StatelessWidget {
  final Book book;
  final bool showRating;

  BookTitle(this.book, this.showRating);

  bool notNull(Object o) => o != null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 5.0),
              showRating ?
                StarRating(
                  value: book.rating,
                  onChanged: (val) => {},
                ) : null
            ].where(notNull).toList(),
          )
        ],
      ),
    );
  }
}
