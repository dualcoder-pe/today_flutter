
import 'package:entity/post/post_vo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:presentation/base/base_state.dart';

part 'posts_list_state.freezed.dart';

class PostsListState extends BaseState {}

class InitPostsListState extends PostsListState {}

@freezed
class PostsListSuccessState extends PostsListState with _$PostsListSuccessState {
  factory PostsListSuccessState(List<PostVO> posts) = _PostsListSuccessState;

  @override
  factory PostsListSuccessState.init() {
    return _PostsListSuccessState(List.empty());
  }
}

@freezed
class PostsListFailureState extends PostsListState with _$PostsListFailureState {
  factory PostsListFailureState(String msg) = _PostsListFailureState;

  @override
  factory PostsListFailureState.init() {
    return _PostsListFailureState("Empty List");
  }
}