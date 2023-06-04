import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../auth/user_vo.dart';

class PostVO extends Equatable {
  final String id;
  final String title;
  final String body;
  final List<String> tags;
  final int publishedDate;
  final UserVO userVO;

  PostVO(this.id, this.title, this.body, this.tags, this.publishedDate, this.userVO);

  String get publishedDateStr =>
      DateFormat("yyyy-MM-dd HH:mm").format(DateTime.fromMillisecondsSinceEpoch(publishedDate)).toString();

  @override
  // TODO: implement props
  List<Object?> get props => [id];

  @override
  String toString() => "$id, $title, $body, $tags, $publishedDate, $userVO";

  factory PostVO.empty() => PostVO("", "", "", List.empty(), 0, UserVO.empty());
}
