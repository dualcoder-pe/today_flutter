import 'dart:convert';
import 'dart:math';

import 'package:common/utils/string.dart';
import 'package:domain/app/app_page.dart';
import 'package:entity/post/post_vo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:presentation/app/app_bloc.dart';
import 'package:presentation/posts/list/posts_list_bloc.dart';
import 'package:presentation/posts/list/posts_list_event.dart';
import 'package:presentation/posts/list/posts_list_state.dart';

import '../../base/base_page.dart';

class PostsListPage extends BasePage {
  const PostsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PostsListBloc>().add(RequestPostsListEvent());
    return BlocBuilder<PostsListBloc, PostsListState>(
        builder: (context, state) => Scaffold(
              appBar: AppBar(
                title: const Text("Posts"),
                actions: actions(context, state),
              ),
              body: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    renderContents(context, state),
                  ],
                ),
              ),
            ));
  }

  List<Widget> actions(BuildContext context, PostsListState state) {
    List<Widget> list = List.empty(growable: true);
    if(context.read<PostsListBloc>().isLoggedIn) {
      list.add(
        IconButton(onPressed: () {
          context.read<AppBloc>().navigate(AppPage.postsWrite);
        }, icon: const Icon(Icons.post_add)),
      );
    }
    return list;
  }
}

Widget renderContents(BuildContext context, PostsListState state) {
  if (state is PostsListSuccessState) {
    return Expanded(
      child: postList(state.posts, (index) {
        final String id = state.posts[index].id;
        context.read<PostsListBloc>().add(ReadPostsListEvent(id));
      }),
    );
  } else if (state is PostsListFailureState) {
    return Text(state.msg);
  }
  //InitPostsListState
  return const Text("Initialized");
}

Widget postList(List<PostVO> posts, Function(int) onPress) {
  return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onPress(index),
          behavior: HitTestBehavior.translucent,
          child: postListItem(posts[index]),
        );
      });
}

Widget postListItem(PostVO post) {
  const double titleSize = 25;
  const double titleMargin = 10;
  const double dateSize = 15;
  const double dateRowMargin = 5;
  const double dateMargin = 20;
  const double bodySize = 15;
  const double itemMargin = 20;
  const Color dateColor = Colors.grey;

  final String rawBody = Document.fromJson(jsonDecode(post.body)).toPlainText();
  int index = 30;
  if(rawBody.count("\n") > 3) {
    final newIndex = rawBody.nthIndexOf("\n", 3);
    index = min(index, newIndex);
  }
  final String body = rawBody.ellipsis(index);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(
        height: itemMargin,
      ),
      Text(
        post.title,
        style: const TextStyle(fontSize: titleSize, fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: titleMargin,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(post.userVO.username, style: const TextStyle(fontSize: dateSize, color: dateColor)),
          const SizedBox(
            width: dateRowMargin,
          ),
          Text(post.publishedDateStr, style: const TextStyle(fontSize: dateSize, color: dateColor)),
        ],
      ),
      const SizedBox(
        height: dateMargin,
      ),
      SizedBox(width: double.infinity, child: Text(body, style: const TextStyle(fontSize: bodySize))),
      const SizedBox(
        height: itemMargin,
      ),
      const Divider(height: 1.0, color: Colors.grey,),
    ],
  );
  // return Text(post.toString());
}
