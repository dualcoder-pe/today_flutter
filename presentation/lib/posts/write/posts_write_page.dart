import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:presentation/posts/write/posts_write_bloc.dart';
import 'package:presentation/posts/write/posts_write_event.dart';
import 'package:presentation/posts/write/posts_write_state.dart';

import '../../base/base_page.dart';

class PostsWritePage extends BasePage {
  PostsWritePage({super.key});

  final TextEditingController _titleController = TextEditingController();
  final QuillController _bodyController = QuillController.basic();
  final TextEditingController _tagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsWriteBloc, PostsWriteState>(
        builder: (context, state) => Scaffold(
              appBar: AppBar(
                title: const Text("Write"),
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
            ));
  }

  Widget renderContents(BuildContext context, PostsWriteState state) {
    if (state is PostsWriteFailureState) {
      return Text(state.msg);
    }
    //InitPostsWriteState
    return writeForm(context, state);
  }

  Widget writeForm(BuildContext context, PostsWriteState state) {
    return Column(
      children: [
        TextField(
          controller: _titleController,
          decoration: const InputDecoration(
            labelText: "Title",
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        QuillToolbar.basic(
          controller: _bodyController,
        ),
        Expanded(child: QuillEditor.basic(controller: _bodyController, readOnly: false)),
      ],
    );
  }

  List<Widget> actions(BuildContext context, PostsWriteState state) {
    return [
      IconButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            builder: (BuildContext context) => bottomSheet(),
          );
        },
        icon: const Icon(Icons.tag),
      ),
      IconButton(
        onPressed: () {
          if (_titleController.text.isNotEmpty && !_bodyController.document.isEmpty()) {
            context
                .read<PostsWriteBloc>()
                .add(SavePostsWriteEvent(_titleController.text, jsonEncode(_bodyController.document.toDelta().toJson()), (state as InitPostsWriteState).tags));
          }
        },
        icon: const Icon(Icons.save),
      ),
    ];
  }

  Widget bottomSheet() {
    return BlocBuilder<PostsWriteBloc, PostsWriteState>(
      builder: (context, state) {
        final bottomInset = MediaQuery.of(context).viewInsets.bottom;
        return Wrap(
          children: [
            Container(
              constraints: BoxConstraints(minHeight: 100 + bottomInset),
              padding: EdgeInsets.only(bottom: bottomInset),
              color: Colors.transparent,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextField(
                          controller: _tagController,
                          decoration: const InputDecoration(
                            labelText: "Tag",
                          ),
                        )),
                        ElevatedButton(
                            onPressed: () {
                              context.read<PostsWriteBloc>().add(SetTagPostsWriteEvent(_tagController.text));
                              _tagController.clear();
                            },
                            child: const Text("Add")),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Builder(builder: (context) {
                      List<Widget> rowItems = List.empty(growable: true);
                      if (state is InitPostsWriteState && state.tags.isNotEmpty) {
                        for (var element in state.tags) {
                          rowItems.add(GestureDetector(
                            onTap: () {
                              context.read<PostsWriteBloc>().add(RemoveTagPostsWriteEvent(element));
                            },
                            child: Text("#$element, "),
                          ));
                        }

                        return Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            children: rowItems,
                          ),
                        );
                      }

                      return const SizedBox(
                        height: 20,
                      );
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
