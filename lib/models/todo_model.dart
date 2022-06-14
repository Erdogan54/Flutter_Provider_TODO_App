class TodoModel {
  final String id;
  final String description;
  final bool complated;

  TodoModel(
      {required this.id, required this.description, this.complated = false});
}
