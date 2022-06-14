import 'package:flutter/material.dart';
import 'package:flutter_provider_todo_app/providers/all_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextFieldWidget extends ConsumerWidget {
  TextFieldWidget({Key? key}) : super(key: key);
  var controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
        decoration: const InputDecoration(labelText: "Neler yapacaksın bugun?"),
        controller: controller,
        onSubmitted: (new_value) {
          ref.read(todoAllListProvider.notifier).addNewToDo(new_value);

          debugPrint(
              "new value: ${new_value}  controller.text: ${controller.text}");
        });
  }
}
