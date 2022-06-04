import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/credit_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimen.dart';
import 'package:movie_app/resources/strings.dart';
import 'package:movie_app/widgets/actors_and_creators_section.dart';
import 'package:movie_app/widgets/gradient_view.dart';
import 'package:movie_app/widgets/rating_view.dart';
import 'package:movie_app/widgets/title_text.dart';

class MoviesDetailsPage extends StatefulWidget {
  final int movieId;

  MoviesDetailsPage(this.movieId);

  @override
  _MoviesDetailsPageState createState() => _MoviesDetailsPageState();
}

class _MoviesDetailsPageState extends State<MoviesDetailsPage> {
  MovieModel mMovieModel = MovieModelImpl();
  final List<String> genreList = [
    "Action",
    "Adventure",
    "Thriller",
  ];
  MovieVO mMovie;
  List<CreditVO> mActorsList;
  List<CreditVO> mCreatorsList;

  @override
  void initState() {
    super.initState();

    // Movie Details
    mMovieModel.getMovieDetails(widget.movieId).then((movie) {
      setState(() {
        this.mMovie = movie;
      });
    });

    // Movie Details Database
    mMovieModel.getMovieDetailsFromDatabase(widget.movieId).then((movie) {
      setState(() {
        this.mMovie = movie;
      });
    });

    mMovieModel.getCreditByMovie(widget.movieId).then((creditsList) {
      setState(() {
        this.mActorsList =
            creditsList.where((credit) => credit.isActor()).toList();
        this.mCreatorsList =
            creditsList.where((credit) => credit.isCreator()).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HOME_SCREEN_BACKGROUND_COLOR,
        child: (mMovie != null)
            ? CustomScrollView(
                slivers: [
                  MovieDetailsSliverAppBarView(
                    () => Navigator.pop(context),
                    mMovie,
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: MEDIUM_MARGIN_2),
                          child: TrailerSection(mMovie),
                        ),
                        SizedBox(height: LARGE_MARGIN),
                        ActorsAndCreatorsSection(
                            MOVIE_DETAILS_SCREEN_ACTORS_TITLES, "",
                            seeMoreButtonVisibility: false,
                            mActorsList: this.mActorsList),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: MEDIUM_MARGIN_2),
                          child: AboutFilmSectionView(mMovie),
                        ),
                        SizedBox(height: LARGE_MARGIN),
                        (mCreatorsList != null && mCreatorsList.isNotEmpty)
                            ? ActorsAndCreatorsSection(
                                MOVIE_DETAILS_SCREEN_CREATORS_TITLES,
                                MOVIE_DETAILS_SCREEN_CREATORS_SEE_MORE,
                                mActorsList: this.mCreatorsList,
                              )
                            : Container(),
                      ],
                    ),
                  )
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

class AboutFilmSectionView extends StatelessWidget {
  final MovieVO mMovie;
  AboutFilmSectionView(this.mMovie);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText("About Film"),
        SizedBox(height: MEDIUM_MARGIN_2),
        MovieFilmInfoView(
          "Original Title",
          mMovie.originalTitle,
        ),
        SizedBox(height: MEDIUM_MARGIN_2),
        MovieFilmInfoView(
          "Type",
          mMovie.genres.map((genre) => genre.name).join(","),
        ),
        SizedBox(height: MEDIUM_MARGIN_2),
        MovieFilmInfoView(
          "Production:",
          mMovie.productionCountries.map((country) => country.name).join(","),
        ),
        SizedBox(height: MEDIUM_MARGIN_2),
        MovieFilmInfoView(
          "Premiere:",
          mMovie.releaseDate,
        ),
        SizedBox(height: MEDIUM_MARGIN_2),
        MovieFilmInfoView(
          "Description",
          mMovie.overview,
        ),
      ],
    );
  }
}

class MovieFilmInfoView extends StatelessWidget {
  final String label;
  final String desc;
  MovieFilmInfoView(this.label, this.desc);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 4,
          child: Text(
            label,
            style: TextStyle(
                color: MOVIE_DETAILS_INFO_TEXT_COLOR,
                fontSize: MEDIUM_MARGIN_2,
                fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(width: MEDIUM_CARD_MARGIN_2),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(
                color: Colors.white,
                fontSize: MEDIUM_MARGIN_2,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class TrailerSection extends StatelessWidget {
  // final List<String> genreList;
  final MovieVO mMovie;
  TrailerSection(this.mMovie);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTimeAndGenreView(
            genreList: mMovie.genres.map((genre) => genre.name).toList()),
        SizedBox(
          height: MEDIUM_MARGIN_3,
        ),
        StorylineView(mMovie.overview),
      ],
    );
  }
}

class StorylineView extends StatelessWidget {
  final String storyline;
  StorylineView(this.storyline);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(MOVIE_DETAILS_STORYlINE_TITLE),
        SizedBox(
          height: MEDIUM_MARGIN_2,
        ),
        Text(
          storyline,
          style: TextStyle(color: Colors.white, fontSize: TEXT_REGULAR_2X),
        ),
        SizedBox(
          height: MEDIUM_MARGIN_2,
        ),
        Row(
          children: [
            MovieDetailsScreenButtonView(
              "PLAY TRAILER",
              PLAY_BUTTON_COLOR,
              Icon(
                Icons.play_circle_fill,
                color: Colors.black54,
              ),
            ),
            SizedBox(width: MEDIUM_CARD_MARGIN_2),
            MovieDetailsScreenButtonView(
              "RATE MOVIE",
              HOME_SCREEN_BACKGROUND_COLOR,
              Icon(
                Icons.star,
                color: PLAY_BUTTON_COLOR,
              ),
              isGhostBtn: true,
            ),
          ],
        ),
      ],
    );
  }
}

class MovieDetailsScreenButtonView extends StatelessWidget {
  final String titleText;
  final Color bgColor;
  final Icon btnIcon;
  final bool isGhostBtn;
  MovieDetailsScreenButtonView(this.titleText, this.bgColor, this.btnIcon,
      {this.isGhostBtn = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MEDIUM_MARGIN_XXlARGE,
      padding: EdgeInsets.symmetric(
        horizontal: MEDIUM_CARD_MARGIN_2,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(LARGE_MARGIN),
        border: (isGhostBtn)
            ? Border.all(
                color: Colors.white,
                width: 2,
              )
            : null,
      ),
      child: Center(
        child: Row(
          children: [
            btnIcon,
            SizedBox(width: SMALL_MARGIN),
            Text(
              titleText,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: TEXT_REGULAR_2X),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieTimeAndGenreView extends StatelessWidget {
  const MovieTimeAndGenreView({
    Key key,
    @required this.genreList,
  }) : super(key: key);

  final List<String> genreList;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.horizontal,
      children: _createMovieTimeAndGenreWidget(),
    );
  }

  // child: Row(
  //     children: [
  //       Icon(
  //         Icons.access_time,
  //         color: PLAY_BUTTON_COLOR,
  //       ),
  //       SizedBox(width: SMALL_MARGIN),
  //       Text(
  //         "2hr 13min",
  //         style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  //       ),
  //       SizedBox(width: MEDIUM_MARGIN),
  //       Row(
  //         children: genreList.map((genre) => GenreChipView(genre)).toList(),
  //       ),
  //       Spacer(),
  //       Icon(
  //         Icons.favorite_border,
  //         color: Colors.white,
  //       ),
  //     ],
  //   ),
  // );
  List<Widget> _createMovieTimeAndGenreWidget() {
    List<Widget> widgets = [
      Icon(
        Icons.access_time,
        color: PLAY_BUTTON_COLOR,
      ),
      SizedBox(width: SMALL_MARGIN),
      Container(
        child: Text(
          "2hr 13min",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(width: MEDIUM_MARGIN),
    ];

    widgets.addAll(genreList.map((genre) => GenreChipView(genre)).toList());
    widgets.add(
      // Spacer(),
      Icon(
        Icons.favorite_border,
        color: Colors.white,
      ),
    );

    return widgets;
  }
}

class GenreChipView extends StatelessWidget {
  final String genreText;
  GenreChipView(this.genreText);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        // alignment: WrapAlignment.start,
        // crossAxisAlignment: WrapCrossAlignment.center,
        // direction: Axis.horizontal,
        children: [
          Chip(
            backgroundColor: MOVIE_DETAIL_SCREEN_CHIP_BACKGROUND_COLOR,
            label: Text(
              genreText,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            width: SMALL_MARGIN,
          ),
        ],
      ),
    );
    // return Chip(
    //   backgroundColor: MOVIE_DETAIL_SCREEN_CHIP_BACKGROUND_COLOR,
    //   label: Text(
    //     genreText,
    //     style: TextStyle(
    //       color: Colors.white,
    //       fontWeight: FontWeight.bold,
    //       fontSize: 12,
    //     ),
    //   ),
    // );
  }
}

class MovieDetailsSliverAppBarView extends StatelessWidget {
  final Function onTapBack;
  final MovieVO mMovie;
  MovieDetailsSliverAppBarView(this.onTapBack, this.mMovie);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: PRIMARY_COLOR,
      automaticallyImplyLeading: false,
      expandedHeight: MOVIE_DETAILS_SCREEN_SLIVER_APP_BAR_HEIGHT,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned.fill(
              child: MoviesDetailsAppBarImageView(mMovie.posterPath),
            ),
            Positioned.fill(
              child: GradientView(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MEDIUM_MARGIN_XlARGE,
                  left: MEDIUM_MARGIN_2,
                ),
                child: BackButtonView(
                  () => onTapBack(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MEDIUM_MARGIN_XlARGE + MEDIUM_CARD_MARGIN_2, // card
                  right: MEDIUM_MARGIN_2,
                ),
                child: SearchButtonView(),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: MEDIUM_MARGIN_2,
                  right: MEDIUM_MARGIN_2,
                  bottom: MEDIUM_MARGIN_XlARGE,
                ),
                child: MovieDetailsAppBarInfoView(mMovie),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieDetailsAppBarInfoView extends StatelessWidget {
  final MovieVO mMovie;
  MovieDetailsAppBarInfoView(this.mMovie);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            MovieDetailsYearView(mMovie.releaseDate.substring(0, 4)),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RatingView(),
                    SizedBox(
                      height: SMALL_MARGIN,
                    ),
                    TitleText("${mMovie.voteCount} VOTES"),
                    SizedBox(
                      height: MEDIUM_MARGIN,
                    ),
                  ],
                ),
                SizedBox(
                  width: MEDIUM_MARGIN,
                ),
                Text(
                  "${mMovie.voteAverage}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MOVIE_DETAILS_RATING_TEXT_SIZE,
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: MEDIUM_MARGIN_2,
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: MEDIUM_MARGIN_XXlARGE,
          ),
          child: Text(
            mMovie.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_HEADING_1X,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}

class MovieDetailsYearView extends StatelessWidget {
  final String year;
  MovieDetailsYearView(this.year);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MEDIUM_MARGIN_2),
      height: LARGE_MARGIN_2,
      decoration: BoxDecoration(
          color: PLAY_BUTTON_COLOR,
          borderRadius: BorderRadius.circular(TEXT_REGULAR_3X)),
      child: Center(
        child: Text(
          year,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ),
    );
  }
}

class SearchButtonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.search, size: MEDIUM_MARGIN_XlARGE, color: Colors.white);
  }
}

class BackButtonView extends StatelessWidget {
  final Function onTapBack;
  BackButtonView(this.onTapBack);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onTapBack();
      },
      child: Container(
        height: MEDIUM_MARGIN_XXlARGE,
        width: MEDIUM_MARGIN_XXlARGE,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black54,
        ),
        child: Icon(Icons.chevron_left,
            size: MEDIUM_MARGIN_XlARGE, color: Colors.white),
      ),
    );
  }
}

class MoviesDetailsAppBarImageView extends StatelessWidget {
  final String imgPath;
  MoviesDetailsAppBarImageView(this.imgPath);
  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$IMAGE_BASE_URL$imgPath",
      fit: BoxFit.cover,
    );
  }
}
