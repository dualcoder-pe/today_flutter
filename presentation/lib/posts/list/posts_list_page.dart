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
import 'package:shimmer/shimmer.dart';

import '../../base/base_page.dart';
import '../../common/indicator.dart';
import '../../common/placeholder.dart';

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
                    Expanded(child: renderContents(context, state)),
                  ],
                ),
              ),
            ));
  }

  List<Widget> actions(BuildContext context, PostsListState state) {
    List<Widget> list = List.empty(growable: true);
    if (context.read<PostsListBloc>().isLoggedIn) {
      list.add(
        IconButton(
            onPressed: () {
              context.read<AppBloc>().navigate(AppPage.postsWrite);
            },
            icon: const Icon(Icons.post_add)),
      );
    }
    return list;
  }
}

Widget renderContents(BuildContext context, PostsListState state) {
  if (state is PostsListSuccessState) {
    return postList(state.posts, (index) {
      final String id = state.posts[index].id;
      context.read<PostsListBloc>().add(ReadPostsListEvent(id));
    });
  } else if (state is PostsListFailureState) {
    return Text(state.msg);
  } else {
    return postList(List.from([PostVO.empty(), PostVO.empty(), PostVO.empty()]), (_) {});
  }
}

Widget postList(List<PostVO> posts, Function(int) onPress) {
  return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onPress(index),
          behavior: HitTestBehavior.translucent,
          child: postListItem(context, posts[index]),
        );
      });
}

Widget postListItem(BuildContext context, PostVO post) {
  const double titleSize = 25;
  const double titleMargin = 10;
  const double dateSize = 15;
  const double dateRowMargin = 5;
  const double dateMargin = 20;
  const double bodySize = 15;
  const double itemMargin = 20;
  const Color dateColor = Colors.grey;

  final String body;
  final String title;
  final String username;
  final String publishedDate;

  if (!post.isEmpty) {
    final String rawBody = Document.fromJson(jsonDecode(post.body)).toPlainText();
    int index = 30;
    if (rawBody.count("\n") > 3) {
      final newIndex = rawBody.nthIndexOf("\n", 3);
      index = min(index, newIndex);
    }
    body = rawBody.ellipsis(index);

    title = post.title;
    username = post.userVO.username;
    publishedDate = post.publishedDateStr;
  } else {
    body = "";
    title = "";
    username = "";
    publishedDate = "";
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(
        height: itemMargin,
      ),
      SizedPlaceholder(
          title.isEmpty,
          double.infinity,
          titleSize,
          Text(
            title,
            style: const TextStyle(fontSize: titleSize, fontWeight: FontWeight.bold),
          )),
      const SizedBox(
        height: titleMargin,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: ListPlaceholder(username.isEmpty, MediaQuery.of(context).size.width / 2, dateSize, [
          Text(username, style: const TextStyle(fontSize: dateSize, color: dateColor)),
          const SizedBox(
            width: dateRowMargin,
          ),
          Text(publishedDate, style: const TextStyle(fontSize: dateSize, color: dateColor)),
        ]),
      ),
      const SizedBox(
        height: dateMargin,
      ),
      SizedPlaceholder(body.isEmpty, double.infinity, bodySize * 3 + 20,
          SizedBox(width: double.infinity, child: Text(body, style: const TextStyle(fontSize: bodySize)))),
      const SizedBox(
        height: itemMargin,
      ),
      const Divider(
        height: 1.0,
        color: Colors.grey,
      ),
    ],
  );
  // return Text(post.toString());
}
