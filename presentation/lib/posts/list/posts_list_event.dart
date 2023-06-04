
import 'package:equatable/equatable.dart';
import 'package:presentation/posts/list/posts_list_state.dart';

class PostsListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitPostsListEvent extends PostsListEvent {}

class RequestPostsListEvent extends PostsListEvent {}

class ReadPostsListEvent extends PostsListEvent {
  final String id;

  ReadPostsListEvent(this.id);

  @override
  List<Object?> get props => [id];
}