import 'package:common/exception/network_exception.dart';
import 'package:common/utils/logger.dart';
import 'package:domain/app/app_navigation.dart';
import 'package:domain/app/app_page.dart';
import 'package:domain/data/repository/post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/base/base_bloc.dart';
import 'package:presentation/posts/list/posts_list_event.dart';

import '../../login/login_bloc.dart';
import 'posts_list_state.dart';

class PostsListBloc extends BaseBloc<PostsListEvent, PostsListState> {
  final PostRepository _postRepository;
  final LoginBloc _loginBloc;
  final AppNavigation _appNavigation;

  PostsListBloc(super.initialState, this._postRepository, this._loginBloc, this._appNavigation) {
    on<RequestPostsListEvent>(_onRequest);
    on<ReadPostsListEvent>(_onRead);
  }

  void _onRequest(RequestPostsListEvent event, Emitter<PostsListState> emit) async {
    try {
      final posts = await _postRepository.getPosts();
      emit(PostsListSuccessState(posts));
    } catch (e) {
      logger(e.toString());
      if (e is NetworkException) {
        emit(PostsListFailureState(e.msg));
      } else {
        emit(PostsListFailureState("Internal Error ${e.toString()}"));
      }
    }
  }

  void _onRead(ReadPostsListEvent event, Emitter<PostsListState> emit) {
    _appNavigation.navigate(AppPage.postsRead, args: {"id": event.id});
  }

  bool get isLoggedIn => _loginBloc.isLoggedIn;
}
