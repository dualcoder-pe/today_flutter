
import 'package:json_annotation/json_annotation.dart';

part 'post_posts_request_dto.g.dart';

@JsonSerializable()
class PostPostsRequestDto {
  final String title;
  final String body;
  final List<String> tags;

  PostPostsRequestDto(this.title, this.body, this.tags);

  Map<String, dynamic> toJson() => _$PostPostsRequestDtoToJson(this);
  factory PostPostsRequestDto.fromJson(Map<String, dynamic> json) => _$PostPostsRequestDtoFromJson(json);
}