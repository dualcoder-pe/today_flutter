import 'package:common/utils/logger.dart';
import 'package:domain/app/app_navigation.dart';
import 'package:domain/app/app_page.dart';
import 'package:domain/data/repository/post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/base/base_bloc.dart';

import 'posts_write_event.dart';
import 'posts_write_state.dart';

class PostsWriteBloc extends BaseBloc<PostsWriteEvent, PostsWriteState> {
  final PostRepository _postRepository;
  final AppNavigation _appNavigation;

  PostsWriteBloc(super.initialState, this._postRepository, this._appNavigation) {
    on<SetTagPostsWriteEvent>(_onSetTag);
    on<RemoveTagPostsWriteEvent>(_onRemoveTag);
    on<SavePostsWriteEvent>(_onSave);
  }

  void _onSetTag(SetTagPostsWriteEvent event, Emitter<PostsWriteState> emit) async {
    if(state is InitPostsWriteState) {
      InitPostsWriteState initState = state as InitPostsWriteState;
      final newTags = List<String>.from(initState.tags, growable: true);
      newTags.add(event.tag);
      emit(initState.copyWith(tags: newTags));
    }
  }

  void _onRemoveTag(RemoveTagPostsWriteEvent event, Emitter<PostsWriteState> emit) async {
    if(state is InitPostsWriteState) {
      InitPostsWriteState initState = state as InitPostsWriteState;
      final newTags = List<String>.from(initState.tags, growable: true);
      newTags.remove(event.tag);
      emit(initState.copyWith(tags: newTags));
    }
  }

  void _onSave(SavePostsWriteEvent event, Emitter<PostsWriteState> emit) async {
    try {
      final res = await _postRepository.postPosts(event.title, event.body, event.tags);
      if (res) {
        _appNavigation.navigate(AppPage.postsList);
      } else {
        emit(PostsWriteFailureState("Failed to save post"));
      }
    } catch (e) {
      logger(e.toString());
      emit(PostsWriteFailureState("Failed to save post"));
    }
  }
}
