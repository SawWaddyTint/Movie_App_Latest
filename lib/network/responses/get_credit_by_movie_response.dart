import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data/vos/credit_vo.dart';

part 'get_credit_by_movie_response.g.dart';

@JsonSerializable()
class GetCreditByMovieResponse {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "cast")
  List<CreditVO> cast;

  GetCreditByMovieResponse(this.id, this.cast);

  factory GetCreditByMovieResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCreditByMovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetCreditByMovieResponseToJson(this);
}
