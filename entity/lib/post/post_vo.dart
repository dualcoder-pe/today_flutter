import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import '../auth/user_vo.dart';

part 'post_vo.freezed.dart';

@freezed
class PostVO with _$PostVO {
  factory PostVO(String id, String title, String body, List<String> tags, int publishedDate, UserVO userVO) = _PostVO;

  factory PostVO.empty() => PostVO("", "", "", List.empty(), 0, UserVO.empty());

  @override
  String toString() => "$id, $title, $body, $tags, $publishedDate, $userVO";
}

extension PostVOExt on PostVO {
  bool get isEmpty => id.isEmpty;
  String get publishedDateStr =>
      DateFormat("yyyy-MM-dd HH:mm").format(DateTime.fromMillisecondsSinceEpoch(publishedDate)).toString();
}
