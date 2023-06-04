import 'package:entity/auth/user_vo.dart';
import 'package:entity/post/post_vo.dart';

class LocalPostDatasource {
  Future<List<PostVO>> getPosts() => Future.value(
        [
          PostVO("123", "title1", "body1", ["tag1"], 12345678, UserVO("1234567", "user1")),
          PostVO("456", "title2", "body2", ["tag2", "tag3"], 12345678, UserVO("1234567", "user1")),
          PostVO("789", "title3", "body3", ["tag2"], 12345678, UserVO("1231241", "user2")),
          PostVO("1011", "title4", "body4", ["tag3"], 12345678, UserVO("1231241", "user2")),
          PostVO("1213", "title5", "body5", ["tag4"], 12345678, UserVO("89798787", "user3")),
        ],
      );
}
