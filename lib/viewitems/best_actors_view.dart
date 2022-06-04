import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/base_actor_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimen.dart';

class BestActorsView extends StatelessWidget {
  final BaseActorVO mActor;
  BestActorsView({this.mActor});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MEDIUM_MARGIN_2),
      width: MOVIE_LIST_ITEM_WIDTH,
      child: Stack(
        children: [
          Positioned.fill(
            child: ActorImageView(actorImgUrl: mActor.profilePath),
          ),
          Padding(
            padding: EdgeInsets.all(MEDIUM_MARGIN),
            child: Align(
              alignment: Alignment.topRight,
              child: FavouriteButtonView(),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: ActorNameAndLikeView(actorName: mActor.name),
          )
        ],
      ),
    );
  }
}

class ActorImageView extends StatelessWidget {
  final String actorImgUrl;
  ActorImageView({this.actorImgUrl});
  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$IMAGE_BASE_URL$actorImgUrl",
      fit: BoxFit.cover,
    );
  }
}

class FavouriteButtonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite_border,
      color: Colors.white,
    );
  }
}

class ActorNameAndLikeView extends StatelessWidget {
  final String actorName;
  ActorNameAndLikeView({this.actorName});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MEDIUM_MARGIN,
        vertical: MEDIUM_MARGIN,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            actorName,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: MEDIUM_MARGIN),
          Row(
            children: [
              Icon(
                Icons.thumb_up,
                color: Colors.amber,
                size: MEDIUM_CARD_MARGIN_2,
              ),
              SizedBox(width: MEDIUM_MARGIN),
              Text(
                "YOU LIKE 13 MOVIES",
                style: TextStyle(
                  color: HOME_SCREEN_LIST_TITLE_COLOR,
                  fontWeight: FontWeight.bold,
                  fontSize: TEXT_SMALL,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
