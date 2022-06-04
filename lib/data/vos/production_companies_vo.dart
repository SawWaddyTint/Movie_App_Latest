import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/persistence/hive_constants.dart';

part 'production_companies_vo.g.dart';

@JsonSerializable()
@HiveType(
    typeId: HIVE_TYPE_ID_PRODUCTION_COMPANIES_VO,
    adapterName: "ProductionCompaniesVOAdapter")
class ProductionCompainesVO {
  @JsonKey(name: "id")
  @HiveField(0)
  int id;

  @JsonKey(name: "logo_path")
  @HiveField(1)
  String logoPath;

  @JsonKey(name: "name")
  @HiveField(2)
  String name;

  @JsonKey(name: "origin_country")
  @HiveField(3)
  String originCountry;

  ProductionCompainesVO(this.id, this.logoPath, this.name, this.originCountry);

  factory ProductionCompainesVO.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompainesVOFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompainesVOToJson(this);
}
