import 'dart:convert';

import 'package:common/utils/logger.dart';
import 'package:entity/post/post_vo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:presentation/common/indicator.dart';

import '../../base/base_page.dart';
import 'posts_read_bloc.dart';
import 'posts_read_event.dart';
import 'posts_read_state.dart';

class PostsReadPage extends BasePage {
  final String _id;

  const PostsReadPage(this._id, {super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PostsReadBloc>().add(RequestPostsReadEvent(_id));
    return BlocBuilder<PostsReadBloc, PostsReadState>(builder: (context, state) {
      final title = state is PostsReadSuccessState ? state.post.title : "";

      if (state is ShowRemoveDialogPostsReadState) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Remove"),
                content: Text("Are you sure you want to remove ${state.title}?"),
                actions: [
                  TextButton(
                      onPressed: () {
                        context.read<PostsReadBloc>().add(HideRemoveDialogPostsReadEvent(state.id));
                      },
                      child: const Text("Cancel")),
                  TextButton(
                      onPressed: () {
                        context.read<PostsReadBloc>().add(RemovePostsReadEvent(state.id));
                      },
                      child: const Text("Remove")),
                ],
              );
            });
      }

      return WillPopScope(
        onWillPop: () async {
          context.read<PostsReadBloc>().add(InitPostsReadEvent());
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
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
                Expanded(
                  child: renderContents(context, state),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget renderContents(BuildContext context, PostsReadState state) {
    if (state is PostsReadFailureState) {
      return Text(state.msg);
    } else if (state is PostsReadSuccessState) {
      return readBody(context, state);
    } else {
      return indicator();
    }
  }

  Widget readBody(BuildContext context, PostsReadSuccessState state) {
    var bodyJson = jsonDecode(state.post.body);
    final bodyController =
        QuillController(document: Document.fromJson(bodyJson), selection: const TextSelection.collapsed(offset: 0));
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        QuillEditor.basic(controller: bodyController, readOnly: true),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          height: 1.0,
          color: Colors.grey,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              state.post.publishedDateStr,
              style: const TextStyle(color: Colors.grey),
            ),
            // const SizedBox(width: 10,),
          ],
        ),
      ],
    );
  }

  List<Widget> actions(BuildContext context, PostsReadState state) {
    if (state is PostsReadSuccessState) {
      logger("${state.post.userVO.id}, ${state.me.id}");
      if (state.me.id.isNotEmpty && state.post.userVO.id == state.me.id) {
        return [
          IconButton(
              onPressed: () {
                context.read<PostsReadBloc>().add(ModifyPostsReadEvent(state.post.id));
              },
              icon: const Icon(Icons.auto_fix_normal)),
          IconButton(
              onPressed: () {
                context.read<PostsReadBloc>().add(ShowRemoveDialogPostsReadEvent(state.post.id, state.post.title));
              },
              icon: const Icon(Icons.delete_forever))
        ];
      }
    }
    return [];
  }

// Widget bottomSheet() {
//   return BlocBuilder<PostsWriteBloc, PostsWriteState>(
//     builder: (context, state) {
//       final bottomInset = MediaQuery
//           .of(context)
//           .viewInsets
//           .bottom;
//       return Wrap(
//         children: [
//           Container(
//             constraints: BoxConstraints(minHeight: 100 + bottomInset),
//             padding: EdgeInsets.only(bottom: bottomInset),
//             color: Colors.transparent,
//             margin: const EdgeInsets.symmetric(horizontal: 16),
//             child: Center(
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                           child: TextField(
//                             controller: _tagController,
//                             decoration: const InputDecoration(
//                               labelText: "Tag",
//                             ),
//                           )),
//                       ElevatedButton(
//                           onPressed: () {
//                             context.read<PostsWriteBloc>().add(SetTagPostsWriteEvent(_tagController.text));
//                             _tagController.clear();
//                           },
//                           child: const Text("Add")),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Builder(builder: (context) {
//                     List<Widget> rowItems = List.empty(growable: true);
//                     if (state is InitPostsWriteState && state.tags.isNotEmpty) {
//                       for (var element in state.tags) {
//                         rowItems.add(GestureDetector(
//                           onTap: () {
//                             context.read<PostsWriteBloc>().add(RemoveTagPostsWriteEvent(element));
//                           },
//                           child: Text("#$element, "),
//                         ));
//                       }
//
//                       return Container(
//                         margin: const EdgeInsets.only(top: 10, bottom: 10),
//                         child: Row(
//                           children: rowItems,
//                         ),
//                       );
//                     }
//
//                     return const SizedBox(
//                       height: 20,
//                     );
//                   }),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
}
