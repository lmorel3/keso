import 'package:flutter/material.dart';

class StatefulStarRating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int rating = 0;
    return StatefulBuilder(
      builder: (context, setState) {
        return StarRating(
          onChanged: (index) {
            setState(() {
              rating = index;
            });
          },
          value: rating,
        );
      },
    );
  }
}

class StarRating extends StatelessWidget {
  final int value;
  final IconData filledStar;
  final IconData unfilledStar;
  final void Function(int index) onChanged;

  const StarRating({
    Key key,
    this.value = 0,
    this.filledStar,
    this.unfilledStar,
    this.onChanged,
  })  : assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).accentColor;
    final size = 36.0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: onChanged != null
              ? () {
            onChanged(value == index + 1 ? index : index + 1);
          }
              : null,
          color: index < value ? color : null,
          iconSize: size,
          icon: Icon(
            index < value
                ? filledStar ?? Icons.star
                : unfilledStar ?? Icons.star_border,
          ),
          padding: EdgeInsets.zero,
          tooltip: "${index + 1} of 5",
        );
      }),
    );
  }
}
