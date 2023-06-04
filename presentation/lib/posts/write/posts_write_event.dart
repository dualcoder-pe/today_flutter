
import 'package:equatable/equatable.dart';
import 'package:presentation/posts/list/posts_list_state.dart';

class PostsWriteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitPostsWriteEvent extends PostsWriteEvent {}

class SetTagPostsWriteEvent extends PostsWriteEvent {
  final String tag;

  SetTagPostsWriteEvent(this.tag);

  @override
  List<Object?> get props => [tag];
}

class RemoveTagPostsWriteEvent extends PostsWriteEvent {
  final String tag;

  RemoveTagPostsWriteEvent(this.tag);

  @override
  List<Object?> get props => [tag];
}

class SavePostsWriteEvent extends PostsWriteEvent {
  final String title;
  final String body;
  final List<String> tags;

  SavePostsWriteEvent(this.title, this.body, this.tags);

  @override
  List<Object?> get props => [title, body, tags.join()];
}