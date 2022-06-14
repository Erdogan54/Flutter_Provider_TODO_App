import 'package:flutter/material.dart';

import 'package:flutter_provider_todo_app/providers/all_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToolBarWidget extends ConsumerWidget {
  const ToolBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int unComplatedTodoCount = ref.watch(unComletedTodoCount);
    TodoListFilterType filterTypeProvider =
        ref.watch(todoListFilterTypeProvider);

    TextStyle _currentTextStyle(TodoListFilterType filterType) {
      return filterType == filterTypeProvider
          ? const TextStyle(fontSize: 16, color: Colors.orange)
          : const TextStyle(fontSize: 13, color: Colors.black);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          unComplatedTodoCount != 0
              ? "$unComplatedTodoCount görev kaldı."
              : "Bütün görevler tamamlandı.",
          overflow: TextOverflow.ellipsis,
        ),
        Tooltip(
          message: "All Todos",
          child: TextButton(
              onPressed: () {
                ref.read(todoListFilterTypeProvider.notifier).state =
                    TodoListFilterType.all;
              },
              child: Text("All",
                  style: _currentTextStyle(TodoListFilterType.all))),
        ),
        Tooltip(
          message: "Only Uncomplated Todos",
          child: TextButton(
              onPressed: () {
                ref.read(todoListFilterTypeProvider.notifier).state =
                    TodoListFilterType.active;
              },
              child: Text("Active",
                  style: _currentTextStyle(TodoListFilterType.active))),
        ),
        Tooltip(
          message: "Only Complated Todos",
          child: TextButton(
              onPressed: () {
                ref.watch(todoListFilterTypeProvider.notifier).state =
                    TodoListFilterType.complated;
              },
              child: Text("Complate",
                  style: _currentTextStyle(TodoListFilterType.complated))),
        )
      ],
    );
  }
}
