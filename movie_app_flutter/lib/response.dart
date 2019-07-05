import 'package:json_annotation/json_annotation.dart';
import 'item.dart';
part 'response.g.dart';

@JsonSerializable()
class Response {
  @JsonKey(name: 'total_pages')
  int totalPages;
  @JsonKey(name: 'total_results')
  int totalResults;
  int page;
  List<Item> results;

  Response(this.totalPages,
           this.totalResults,
           this.page,
           this.results);

  factory Response.fromJson(Map<String, dynamic> json) => _$ResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}

@JsonSerializable()
class APIErrorResponse {
  @JsonKey(name: 'status_code')
  int code;
  String message;
  bool success;

  APIErrorResponse(this.code,
                   this.message,
                   this.success);


  factory APIErrorResponse.fromJson(Map<String, dynamic> json) => _$APIErrorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$APIErrorResponseToJson(this);
}