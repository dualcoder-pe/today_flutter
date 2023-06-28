import 'package:entity/auth/user_vo.dart';
import 'package:entity/post/post_vo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:presentation/base/base_state.dart';

part 'posts_read_state.freezed.dart';

class PostsReadState extends BaseState {}

class InitPostsReadState extends PostsReadState {}

@freezed
class PostsReadSuccessState extends PostsReadState with _$PostsReadSuccessState {
  factory PostsReadSuccessState(PostVO post, UserVO me) = _PostsReadSuccessState;
}

@freezed
class PostsReadFailureState extends PostsReadState with _$PostsReadFailureState {
  factory PostsReadFailureState(String msg) = _PostsReadFailureState;
}

@freezed
class ShowRemoveDialogPostsReadState extends PostsReadState with _$ShowRemoveDialogPostsReadState {
  factory ShowRemoveDialogPostsReadState(String title, String id) = _ShowRemoveDialogPostsReadState;
}