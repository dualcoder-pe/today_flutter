import 'package:data/model/posts/req/post_posts_request_dto.dart';

import '../model/posts/post_dto.dart';
import 'api/api.dart';

class RemotePostDatasource {
  final Api _api;

  RemotePostDatasource(this._api);

  Future<List<PostDto>> getPosts(int? page, String? username, String? tag) {
    return _api.getPosts(page, username, tag);
  }

  Future<PostDto?> postPosts(PostPostsRequestDto req) => _api.postPosts(req.toJson());

  Future<PostDto?> getPostsById(String id) => _api.getPostsById(id);

  Future<void> deletePostsById(String id) => _api.deletePostsById(id);

  Future<PostDto?> patchPostsById(String id) => _api.patchPostsById(id);
}
