import 'package:entity/post/post_vo.dart';

abstract class PostRepository {
  Future<List<PostVO>> getPosts({int? page, String? username, String? tag});
  Future<bool> postPosts(String title, String body, List<String> tags);
  Future<PostVO> getPostsById(String id);
  Future<bool> deletePostsById(String id);
  Future<PostVO> patchPostsById(String id);
}