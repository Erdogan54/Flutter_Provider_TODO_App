import 'package:flutter/material.dart';
import 'package:flutter_provider_todo_app/providers/all_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/future_provider.dart';
import 'widgets/textfield_widget.dart';
import 'widgets/title_widget.dart';
import 'widgets/todo_list_item_widget.dart';
import 'widgets/toolbar_widget.dart';

class TodoApp extends ConsumerWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allTodos = ref.watch(filteredTodoList);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListView(
          children: [
            const TitleWidget(),
            TextFieldWidget(),
            const SizedBox(height: 20),
            const ToolBarWidget(),
            allTodos.isEmpty
                ? const Center(
                    child: Text("Bu koşullarda bir göreviniz bulunmamaktadır."))
                : const SizedBox(),
            for (var i = 0; i < allTodos.length; i++)
              Dismissible(
                key: Key(allTodos[i].id),
                direction: DismissDirection.startToEnd,
                onDismissed: (directions) {
                  ref.read(todoAllListProvider.notifier).delete(allTodos[i]);
                },
                child: ProviderScope(overrides: [
                  currentTodoProvider.overrideWithValue(allTodos[i])
                ], child: const TodoListItemWidget()),
              ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const FutureProviderExample())));
                },
                child: const Text("Future Provider"))
          ],
        ),
      ),
    );
  }
}
