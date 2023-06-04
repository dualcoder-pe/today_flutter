
import 'package:common/utils/logger.dart';
import 'package:entity/auth/user_vo.dart';
import 'package:entity/post/post_vo.dart';
import 'package:json_annotation/json_annotation.dart';

import '../auth/user_dto.dart';

part 'post_dto.g.dart';

@JsonSerializable()
class PostDto {
  final String? id;
  final String? title;
  final String? body;
  final List<String>? tags;
  final int? publishedDate;
  final UserDto? user;

  PostDto(this.id, this.title, this.body, this.tags, this.publishedDate, this.user);

  factory PostDto.fromJson(Map<String, dynamic> json) => _$PostDtoFromJson(json);

  @override
  String toString() => "$id, $title, $body, $tags, $publishedDate, $user";
}

extension PostDtoExt on PostDto {
  PostVO toVO() {
    return PostVO(
        id!, title ?? "Empty", body ?? "Empty", tags ?? List.empty(), publishedDate ?? 0, user?.toVO() ?? UserVO.empty());
  }
}