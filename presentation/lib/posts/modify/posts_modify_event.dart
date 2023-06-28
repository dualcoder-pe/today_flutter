
import 'package:equatable/equatable.dart';
import 'package:presentation/posts/list/posts_list_state.dart';

class PostsModifyEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitPostsModifyEvent extends PostsModifyEvent {}

class RequestPostsModifyEvent extends PostsModifyEvent {
  final String id;

  RequestPostsModifyEvent(this.id);

  @override
  List<Object> get props => [id];
}

class SetTagPostsModifyEvent extends PostsModifyEvent {
  final String tag;

  SetTagPostsModifyEvent(this.tag);

  @override
  List<Object?> get props => [tag];
}

class RemoveTagPostsModifyEvent extends PostsModifyEvent {
  final String tag;

  RemoveTagPostsModifyEvent(this.tag);

  @override
  List<Object?> get props => [tag];
}

class SavePostsModifyEvent extends PostsModifyEvent {
  final String title;
  final String body;
  final List<String> tags;

  SavePostsModifyEvent(this.title, this.body, this.tags);

  @override
  List<Object?> get props => [title, body, tags.join()];
}