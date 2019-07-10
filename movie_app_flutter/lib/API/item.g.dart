// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
      json['vote_count'] as int,
      json['id'] as int,
      (json['vote_average'] as num)?.toDouble(),
      json['title'] as String,
      json['poster_path'] as String,
      json['overview'] as String,
      json['release_date'] as String,
      json['first_air_date'] as String,
      json['backdrop_path'] as String);
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'vote_count': instance.voteCount,
      'id': instance.id,
      'vote_average': instance.voteAverage,
      'title': instance.title,
      'poster_path': instance.posterPath,
      'overview': instance.overview,
      'release_date': instance.releaseDate,
      'first_air_date': instance.firstAirDate,
      'backdrop_path': instance.backdropPath
    };
