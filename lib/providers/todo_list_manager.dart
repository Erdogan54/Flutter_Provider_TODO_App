import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/todo_model.dart';

class TodoListManager extends StateNotifier<List<TodoModel>> {
  // TodoListManager(super.state);
  TodoListManager([List<TodoModel>? notifierTodoList])
      : super(notifierTodoList ?? []);

  void addNewToDo(String description) {
    var eklenecekTodo =
        TodoModel(id: const Uuid().v4(), description: description);
    state = [...state, eklenecekTodo];
  }

  void toggle(String id) {
    /* List<TodoModel> newstate = [];
    for (var i = 0; i < state.length; i++) {
      newstate.add(state[i]);
      if (state[i].id == id) {
        newstate
            .add(TodoModel(id: state[i].id,description: state[i].description, complated: !state[i].complated));
      }
    } */

    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
            id: todo.id,
            description: todo.description,
            complated: !todo.complated,
          )
        else
          todo
    ];
  }

  void edit({required String id, required String description}) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
            id: todo.id,
            description: description,
            complated: todo.complated,
          )
        else
          todo
    ];
  }

  void delete(TodoModel todo) {
    state = state.where((element) => element.id != todo.id).toList();
  }

}
