import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/resources/dimen.dart';

class RatingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
        initialRating: 5.0,
        itemBuilder: (BuildContext context, int index) {
          return Icon(
            Icons.star,
            color: Colors.amber,
          );
        },
        itemSize: MEDIUM_MARGIN_2,
        onRatingUpdate: (rating) {
          print(rating);
        });
  }
}
