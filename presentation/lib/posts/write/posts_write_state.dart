import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:presentation/base/base_state.dart';

part 'posts_write_state.freezed.dart';

class PostsWriteState extends BaseState {}

abstract class HasTags {
  List<String> get tags;
}

@freezed
class InitPostsWriteState extends PostsWriteState with _$InitPostsWriteState {
  @Implements<HasTags>()
  factory InitPostsWriteState(List<String> tags) = _InitPostsWriteState;

  @override
  factory InitPostsWriteState.init() {
    return _InitPostsWriteState(List.empty(growable: true));
  }
}

@freezed
class PostsWriteFailureState extends PostsWriteState with _$PostsWriteFailureState {
  factory PostsWriteFailureState(String msg) = _PostsWriteFailureState;

  @override
  factory PostsWriteFailureState.init() {
    return _PostsWriteFailureState("failed to save post");
  }
}
