import 'package:flutter_provider_todo_app/providers/todo_list_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/todo_model.dart';

enum TodoListFilterType { all, active, complated }

final todoListFilterTypeProvider = StateProvider<TodoListFilterType>((ref) {
  return TodoListFilterType.all;
});

final todoAllListProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>((ref) {
  return TodoListManager([
    TodoModel(id: const Uuid().v4(), description: "sporrrrr"),
    TodoModel(id: const Uuid().v4(), description: "araba"),
    TodoModel(id: const Uuid().v4(), description: "yüzme"),
  ]);
});



final filteredTodoList = Provider<List<TodoModel>>((ref) {
  final filterType = ref.watch(todoListFilterTypeProvider);
  final todoAllList = ref.watch(todoAllListProvider);

  switch (filterType) {
    case TodoListFilterType.all:
      return todoAllList;
    case TodoListFilterType.active:
      return todoAllList.where((element) => !element.complated).toList();
    case TodoListFilterType.complated:
      return todoAllList.where((element) => element.complated).toList();
  }
});

final unComletedTodoCount = Provider<int>(((ref) {
  final allTodo = ref.watch(todoAllListProvider);
  final count = allTodo.where((element) => !element.complated).length;
  return count;
}));

final currentTodoProvider = Provider<TodoModel>((ref) {
  throw UnimplementedError();
});
