import 'package:entity/post/post_vo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:presentation/base/base_state.dart';

part 'posts_modify_state.freezed.dart';

class PostsModifyState extends BaseState {}

@freezed
class InitPostsModifyState extends PostsModifyState with _$InitPostsModifyState {
  factory InitPostsModifyState() = _InitPostsModifyState;

  factory InitPostsModifyState.init() {
    return _InitPostsModifyState();
  }
}

@freezed
class PostsModifyLoadedState extends PostsModifyState with _$PostsModifyLoadedState {
  factory PostsModifyLoadedState(PostVO post) = _PostsModifyLoadedState;
}

@freezed
class PostsModifyLoadingFailedState extends PostsModifyState with _$PostsModifyLoadingFailedState {
  factory PostsModifyLoadingFailedState(String msg) = _PostsModifyLoadingFailedState;
}

@freezed
class PostsModifyFailureState extends PostsModifyState with _$PostsModifyFailureState {
  factory PostsModifyFailureState(String msg) = _PostsModifyFailureState;
}
