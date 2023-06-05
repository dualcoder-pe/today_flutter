import 'dart:async';

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../model/auth/res/login_response_dto.dart';
import '../../model/posts/post_dto.dart';

part 'api.g.dart';

@RestApi()
abstract class Api {
  factory Api(Dio dio, {String baseUrl}) = _Api;

  @POST("auth/register")
  Future<LoginResponseDto> register(@Body() Map<String, dynamic> map);

  @POST("auth/login")
  Future<LoginResponseDto> login(@Body() Map<String, dynamic> map);

  @GET("auth/check")
  Future<LoginResponseDto> check();

  @POST("auth/logout")
  Future<void> logout();

  @GET("posts")
  Future<List<PostDto>> getPosts(int? page, String? username, String? tag);

  @POST("posts")
  Future<PostDto?> postPosts(@Body() Map<String, dynamic> map);

  @GET("posts/{id}")
  Future<PostDto?> getPostsById(@Path("id") String id);

  @DELETE("posts/{id}")
  Future<void> deletePostsById(@Path("id") String id);

  @PATCH("posts/{id}")
  Future<PostDto?> patchPostsById(@Path("id") String id);
}
