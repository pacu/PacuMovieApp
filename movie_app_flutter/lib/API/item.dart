import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';


@JsonSerializable()
class Item {
  @JsonKey(name: 'vote_count')
  int voteCount;
  int id;
  @JsonKey(name: 'vote_average')
  double voteAverage;
  String title;
  @JsonKey(name: 'poster_path')
  String posterPath;
  String overview;
  @JsonKey(name: 'release_date')
  String releaseDate;
  @JsonKey(name: 'first_air_date')
  String firstAirDate;
  @JsonKey(name: 'backdrop_path')
  String backdropPath;

  Item(this.voteCount, 
            this.id, 
            this.voteAverage,
            this.title,
            this.posterPath,
            this.overview,
            this.releaseDate,
            this.firstAirDate,
            this.backdropPath);
  
  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}