
import 'package:json_annotation/json_annotation.dart';

part 'get_posts_request_dto.g.dart';

@JsonSerializable()
class GetPostsRequestDto {
  final int? page;
  final String? userId;
  final String? tag;

  GetPostsRequestDto({this.page, this.userId, this.tag});

  Map<String, dynamic> toJson() => _$GetPostsRequestDtoToJson(this);
  factory GetPostsRequestDto.fromJson(Map<String, dynamic> json) => _$GetPostsRequestDtoFromJson(json);
}