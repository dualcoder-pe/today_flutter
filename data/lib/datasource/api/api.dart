import 'dart:async';

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../model/auth/res/login_response_dto.dart';
import '../../model/posts/post_dto.dart';

part 'api.g.dart';

@RestApi()
abstract class Api {
  factory Api(Dio dio, {String baseUrl}) = _Api;

  @POST("api/auth/register")
  Future<LoginResponseDto> register(@Body() Map<String, dynamic> map);

  @POST("api/auth/login")
  Future<LoginResponseDto> login(@Body() Map<String, dynamic> map);

  @GET("api/auth/check")
  Future<LoginResponseDto> check();

  @POST("api/auth/logout")
  Future<void> logout();

  @GET("api/posts")
  Future<List<PostDto>> getPosts(int? page, String? username, String? tag);

  @POST("api/posts")
  Future<PostDto?> postPosts(@Body() Map<String, dynamic> map);

  @GET("api/posts/{id}")
  Future<PostDto?> getPostsById(@Path("id") String id);

  @DELETE("api/posts/{id}")
  Future<void> deletePostsById(@Path("id") String id);

  @PATCH("api/posts/{id}")
  Future<PostDto?> patchPostsById(@Path("id") String id);
}
