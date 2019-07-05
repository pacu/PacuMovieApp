// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Response _$ResponseFromJson(Map<String, dynamic> json) {
  return Response(
      json['total_pages'] as int,
      json['total_results'] as int,
      json['page'] as int,
      (json['results'] as List)
          ?.map((e) =>
              e == null ? null : Item.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
      'page': instance.page,
      'results': instance.results
    };

APIErrorResponse _$APIErrorResponseFromJson(Map<String, dynamic> json) {
  return APIErrorResponse(json['status_code'] as int, json['message'] as String,
      json['success'] as bool);
}

Map<String, dynamic> _$APIErrorResponseToJson(APIErrorResponse instance) =>
    <String, dynamic>{
      'status_code': instance.code,
      'message': instance.message,
      'success': instance.success
    };
