import 'package:common/exception/network_exception.dart';
import 'package:common/utils/logger.dart';
import 'package:domain/app/app_navigation.dart';
import 'package:domain/app/app_page.dart';
import 'package:domain/data/repository/post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/base/base_bloc.dart';

import 'posts_modify_event.dart';
import 'posts_modify_state.dart';

class PostsModifyBloc extends BaseBloc<PostsModifyEvent, PostsModifyState> {
  final PostRepository _postRepository;
  final AppNavigation _appNavigation;

  PostsModifyBloc(super.initialState, this._postRepository, this._appNavigation) {
    on<RequestPostsModifyEvent>(_onRequest);
    on<SetTagPostsModifyEvent>(_onSetTag);
    on<RemoveTagPostsModifyEvent>(_onRemoveTag);
    on<SavePostsModifyEvent>(_onSave);
  }

  void _onRequest(RequestPostsModifyEvent event, Emitter<PostsModifyState> emit) async {
    try {
      final posts = await _postRepository.getPostsById(event.id);
      emit(PostsModifyLoadedState(posts));
    } catch (e) {
      logger(e.toString());
      if (e is NetworkException) {
        emit(PostsModifyFailureState(e.msg));
      } else {
        emit(PostsModifyFailureState("Internal Error ${e.toString()}"));
      }
    }
  }

  void _onSetTag(SetTagPostsModifyEvent event, Emitter<PostsModifyState> emit) async {
    if(state is PostsModifyLoadedState) {
      PostsModifyLoadedState loadedState = state as PostsModifyLoadedState;
      final newTags = List<String>.from(loadedState.post.tags, growable: true);
      newTags.add(event.tag);
      emit(loadedState.copyWith(post: loadedState.post.copyWith(tags: newTags)));
    }
  }

  void _onRemoveTag(RemoveTagPostsModifyEvent event, Emitter<PostsModifyState> emit) async {
    if(state is PostsModifyLoadedState) {
      PostsModifyLoadedState loadedState = state as PostsModifyLoadedState;
      final newTags = List<String>.from(loadedState.post.tags, growable: true);
      newTags.remove(event.tag);
      emit(loadedState.copyWith(post: loadedState.post.copyWith(tags: newTags)));
    }
  }

  void _onSave(SavePostsModifyEvent event, Emitter<PostsModifyState> emit) async {
    try {
      final res = await _postRepository.postPosts(event.title, event.body, event.tags);
      if (res) {
        _appNavigation.navigate(AppPage.postsList);
      } else {
        emit(PostsModifyFailureState("Failed to save post"));
      }
    } catch (e) {
      logger(e.toString());
      emit(PostsModifyFailureState("Failed to save post"));
    }
  }
}
