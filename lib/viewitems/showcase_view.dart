import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/resources/dimen.dart';
import 'package:movie_app/viewitems/banner_view.dart';
import 'package:movie_app/widgets/play_button_view.dart';
import 'package:movie_app/widgets/title_text.dart';

class ShowcaseView extends StatelessWidget {
  final MovieVO mMovie;
  ShowcaseView(this.mMovie);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MEDIUM_MARGIN_2),
      width: 300,
      child: Stack(
        children: [
          ShowCaseImageView(mImageUrl: mMovie.posterPath),
          Align(
            alignment: Alignment.center,
            child: PlayButtonView(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(MEDIUM_MARGIN_2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    mMovie.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: TEXT_REGULAR_3X,
                    ),
                  ),
                  SizedBox(height: SMALL_MARGIN),
                  // TitleText("15 DECEMBER 2016"),
                  TitleText(mMovie.releaseDate),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ShowCaseImageView extends StatelessWidget {
  final String mImageUrl;
  ShowCaseImageView({this.mImageUrl});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.network(
        "$IMAGE_BASE_URL$mImageUrl",
        fit: BoxFit.cover,
      ),
    );
  }
}
