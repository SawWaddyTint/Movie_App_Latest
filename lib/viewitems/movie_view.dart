import 'package:flutter/material.dart';

import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/resources/dimen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/widgets/rating_view.dart';

class MovieView extends StatelessWidget {
  final Function(int) onTapMovie;
  final MovieVO mMovie;
  MovieView(this.onTapMovie, this.mMovie);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MEDIUM_MARGIN),
      width: MOVIE_LIST_ITEM_WIDTH,
      child: Column(
        // textDirection: TextDirection.,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              onTapMovie(mMovie.id);
            },
            child: Image.network(
              "$IMAGE_BASE_URL${mMovie.posterPath}",
              fit: BoxFit.cover,
              height: Movie_View_Height,
            ),
          ),
          SizedBox(height: MEDIUM_MARGIN),
          Text(
            mMovie.title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: TEXT_REGULAR_2X,
            ),
          ),
          SizedBox(width: MEDIUM_MARGIN_2),
          Row(
            children: [
              Text(
                "${mMovie.voteAverage}",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: TEXT_REGULAR,
                ),
              ),
              SizedBox(width: MEDIUM_MARGIN),
              RatingView(),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [],
          ),
        ],
      ),
    );
  }
}
