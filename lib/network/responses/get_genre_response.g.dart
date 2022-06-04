// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_genre_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetGenreResponse _$GetGenreResponseFromJson(Map<String, dynamic> json) {
  return GetGenreResponse(
    genres: (json['genres'] as List)
        ?.map((e) =>
            e == null ? null : GenreVO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GetGenreResponseToJson(GetGenreResponse instance) =>
    <String, dynamic>{
      'genres': instance.genres,
    };
