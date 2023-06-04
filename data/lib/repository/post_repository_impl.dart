import 'dart:io';

import 'package:common/exception/network_exception.dart';
import 'package:common/utils/logger.dart';
import 'package:data/model/posts/post_dto.dart';
import 'package:data/model/posts/req/post_posts_request_dto.dart';
import 'package:dio/dio.dart';
import 'package:domain/data/repository/post_repository.dart';
import 'package:entity/post/post_vo.dart';

import '../datasource/local_post_datasource.dart';
import '../datasource/remote_post_datasource.dart';

class PostRepositoryImpl extends PostRepository {
  final LocalPostDatasource _localPostDatasource;
  final RemotePostDatasource _remotePostDatasource;

  PostRepositoryImpl(this._localPostDatasource, this._remotePostDatasource);

  @override
  Future<List<PostVO>> getPosts({int? page, String? username, String? tag}) {
    return _remotePostDatasource.getPosts(page, username, tag).then((value) {
      return value.map((e) => e.toVO()).toList();
    }).catchError((e) {
      if (e is DioError) {
        logger("error => ${e.response?.statusCode}, ${e.response?.statusMessage}");
        switch (e.response?.statusCode) {
          case HttpStatus.noContent:
            return List<PostVO>.empty();
          default:
            throw const NetworkException("Failed to get posts");
        }
      } else {
        logger(e);
      }
    });
    // return _localPostDatasource.getPosts();
  }

  @override
  Future<bool> postPosts(String title, String body, List<String> tags) {
    return _remotePostDatasource.postPosts(PostPostsRequestDto(title, body, tags)).then((value) => value != null);
  }

  @override
  Future<bool> deletePostsById(String id) {
    return _remotePostDatasource.deletePostsById(id).then((value) => true).catchError((e) {
      if (e is DioError) {
        logger("error => ${e.response?.statusCode}, ${e.response?.statusMessage}");
        throw const NetworkException("Failed to delete posts");
      } else {
        logger(e);
      }
      return false;
    });
  }

  @override
  Future<PostVO> getPostsById(String id) {
    return _remotePostDatasource.getPostsById(id).then((value) {
      if(value != null) {
        return value.toVO();
      } else {
        throw const NetworkException("Can't find post");
      }
    });
  }

  @override
  Future<PostVO> patchPostsById(String id) {
    return _remotePostDatasource.patchPostsById(id).then((value) {
      if(value != null) {
        return value.toVO();
      } else {
        throw const NetworkException("Can't modify post");
      }
    });
  }
}
