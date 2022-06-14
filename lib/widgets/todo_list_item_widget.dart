import 'package:flutter/material.dart';
import 'package:flutter_provider_todo_app/providers/all_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoListItemWidget extends ConsumerStatefulWidget {
  const TodoListItemWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TodoListItemWidgetState();
}

class _TodoListItemWidgetState extends ConsumerState<TodoListItemWidget> {
  late FocusNode _focusNode;
  late TextEditingController _textEditingController;
  late bool _hasFocus;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _textEditingController = TextEditingController();
    _hasFocus = false;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  
     final currenTodoItem = ref.watch(currentTodoProvider);

    return Focus(
      onFocusChange: (isFocus) {
        if (!isFocus) {
          setState(() {
            _hasFocus = false;
            ref.read(todoAllListProvider.notifier).edit(
                id: currenTodoItem.id, description: _textEditingController.text);
          });
        }
      },
      child: ListTile(
        onTap: () {
          setState(() {
            _hasFocus = true;
            _focusNode.requestFocus();
            _textEditingController.text = currenTodoItem.description;
          });
        },
        leading: Checkbox(
          value: currenTodoItem.complated,
          onChanged: (value) {
            ref.read(todoAllListProvider.notifier).toggle(currenTodoItem.id);
            debugPrint(value.toString());
          },
        ),
        title: _hasFocus
            ? TextField(
                controller: _textEditingController,
                focusNode: _focusNode,
                onSubmitted: (value) {
                  setState(() {
                    _textEditingController.text = value;
                  });
                },
              )
            : Text(currenTodoItem.description),
      ),
    );
  }
}
