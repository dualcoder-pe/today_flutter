import 'package:common/exception/network_exception.dart';
import 'package:common/utils/logger.dart';
import 'package:domain/service/navigation_service.dart';
import 'package:domain/app/app_page.dart';
import 'package:domain/data/repository/post_repository.dart';
import 'package:entity/auth/user_vo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/base/base_bloc.dart';
import 'package:presentation/login/login_state.dart';

import '../../login/login_bloc.dart';
import 'posts_read_event.dart';
import 'posts_read_state.dart';

class PostsReadBloc extends BaseBloc<PostsReadEvent, PostsReadState> {
  final PostRepository _postRepository;
  final NavigationService _navigationService;
  final LoginBloc _loginBloc;
  PostsReadState? _prevState;


  PostsReadBloc(super.initialState, this._postRepository, this._navigationService, this._loginBloc) {
    on<InitPostsReadEvent>(_onInit);
    on<RequestPostsReadEvent>(_onRequest);
    on<ModifyPostsReadEvent>(_onModify);
    on<ShowRemoveDialogPostsReadEvent>(_onShowRemovePopup);
    on<HideRemoveDialogPostsReadEvent>(_onHideRemovePopup);
    on<RemovePostsReadEvent>(_onRemove);
  }

  void _onInit(InitPostsReadEvent event, Emitter<PostsReadState> emit) async {
    emit(InitPostsReadState());
  }

  void _onRequest(RequestPostsReadEvent event, Emitter<PostsReadState> emit) async {
    try {
      final posts = await _postRepository.getPostsById(event.id);
      final me = _loginBloc.state is LoginSuccessState ? (_loginBloc.state as LoginSuccessState).userInfo : UserVO.empty();
      emit(PostsReadSuccessState(posts, me));
    } catch (e) {
      logger(e.toString());
      if (e is NetworkException) {
        emit(PostsReadFailureState(e.msg));
      } else {
        emit(PostsReadFailureState("Internal Error ${e.toString()}"));
      }
    }
  }

  void _onModify(ModifyPostsReadEvent event, Emitter<PostsReadState> emit) async {
    _navigationService.navigate(AppPage.postsModify);
  }

  void _onShowRemovePopup(ShowRemoveDialogPostsReadEvent event, Emitter<PostsReadState> emit) async {
    _prevState = state;
    emit(ShowRemoveDialogPostsReadState(event.title, event.id));
  }

  void _onHideRemovePopup(HideRemoveDialogPostsReadEvent event, Emitter<PostsReadState> emit) async {
    if(_prevState != null) {
      emit(_prevState!);
    } else {
      emit(InitPostsReadState());
      add(RequestPostsReadEvent(event.id));
    }
  }

  void _onRemove(RemovePostsReadEvent event, Emitter<PostsReadState> emit) async {
    try {
      await _postRepository.deletePostsById(event.id);
    } catch (e) {
      logger(e.toString());
      if (e is NetworkException) {
        emit(PostsReadFailureState(e.msg));
      } else {
        emit(PostsReadFailureState("Internal Error ${e.toString()}"));
      }
    }
  }
}
