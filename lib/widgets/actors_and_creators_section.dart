import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/base_actor_vo.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimen.dart';
import 'package:movie_app/viewitems/best_actors_view.dart';
import 'package:movie_app/widgets/title_text_with_see_more_view.dart';

class ActorsAndCreatorsSection extends StatelessWidget {
  final String titleText;
  final String seeMoreText;
  final bool seeMoreButtonVisibility;
  final List<BaseActorVO> mActorsList;

  const ActorsAndCreatorsSection(this.titleText, this.seeMoreText,
      {this.seeMoreButtonVisibility = true, this.mActorsList});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      padding: EdgeInsets.only(
        top: MEDIUM_MARGIN_2,
        bottom: MEDIUM_MARGIN_XXlARGE,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MEDIUM_MARGIN_2),
            child: TitleTextWithSeeMoreView(titleText, seeMoreText,
                seeMoreButtonVisibility: this.seeMoreButtonVisibility),
          ),
          SizedBox(height: MEDIUM_MARGIN_2),
          Container(
            height: BANNER_SECTION_HEIGHT,
            child: ListView(
              padding: EdgeInsets.only(left: MEDIUM_MARGIN_2),
              scrollDirection: Axis.horizontal,
              children: mActorsList
                  .map((actor) => BestActorsView(mActor: actor))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
