import 'package:equatable/equatable.dart';

class PostsReadEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitPostsReadEvent extends PostsReadEvent {}

class RequestPostsReadEvent extends PostsReadEvent {
  final String id;

  RequestPostsReadEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ModifyPostsReadEvent extends PostsReadEvent {
  final String id;

  ModifyPostsReadEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class HideRemoveDialogPostsReadEvent extends PostsReadEvent {
  final String id;

  HideRemoveDialogPostsReadEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ShowRemoveDialogPostsReadEvent extends PostsReadEvent {
  final String id;
  final String title;

  ShowRemoveDialogPostsReadEvent(this.id, this.title);

  @override
  List<Object?> get props => [id, title];
}

class RemovePostsReadEvent extends PostsReadEvent {
  final String id;

  RemovePostsReadEvent(this.id);

  @override
  List<Object?> get props => [id];
}
