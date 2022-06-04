import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/responses/get_actors_response.dart';
import 'package:movie_app/network/responses/get_credit_by_movie_response.dart';
import 'package:movie_app/network/responses/get_genre_response.dart';
import 'package:movie_app/network/responses/get_movies_by_genre_response.dart';
import 'package:movie_app/network/responses/get_now_playing_response.dart';
// import 'package:movieapp/network/responses/get_now_playing_response.dart';
import 'package:retrofit/http.dart';
import 'api_constants.dart';

part 'the_movie_api.g.dart';

@RestApi(baseUrl: BASE_URL_DIO)
abstract class TheMovieApi {
  factory TheMovieApi(Dio dio) = _TheMovieApi;

  @GET(ENDPOINT_GET_NOW_PLAYING)
  Future<MovieListResponse> getNowPlayingMovies(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_lANGUAGE) String language,
    @Query(PARAM_PAGE) String page,
  );

  @GET(ENDPOINT_GET_POPULAR)
  Future<MovieListResponse> getPopularMovies(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_lANGUAGE) String language,
    @Query(PARAM_PAGE) String page,
  );

  @GET(ENDPOINT_GET_TOP_RATED)
  Future<MovieListResponse> getTopRatedMovies(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_lANGUAGE) String language,
    @Query(PARAM_PAGE) String page,
  );

  @GET(ENDPOINT_GET_GENRES)
  Future<GetGenreResponse> getGenres(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_lANGUAGE) String language,
  );

  @GET(ENDPOINT_GET_MOVIES_BY_GENRES)
  Future<MovieListResponse> getMoviesByGenre(
    @Query(PARAM_GENRE_ID) String genreId,
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_lANGUAGE) String language,
  );

  @GET(ENDPOINT_GET_ACTORS)
  Future<GetActorsResponse> getActors(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_lANGUAGE) String language,
    @Query(PARAM_PAGE) String page,
  );

  @GET("$ENDPOINT_GET_MOVIE_DETAILS/{movie_id}")
  Future<MovieVO> getMovieDetails(
    @Path("movie_id") String movieId,
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_lANGUAGE) String language,
    @Query(PARAM_PAGE) String page,
  );

  @GET("$ENDPOINT_GET_CREDIT_BY_MOVIE/{movie_id}/credits")
  Future<GetCreditByMovieResponse> getCreditByMovieResponse(
    @Path("movie_id") String movieId,
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_lANGUAGE) String language,
    @Query(PARAM_PAGE) String page,
  );
}
