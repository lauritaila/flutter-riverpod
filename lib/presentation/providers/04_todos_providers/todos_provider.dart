import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:riverpod_app/domain/entities/todo.dart';

part 'todos_provider.g.dart';

const uuid = Uuid();

enum FilterType { all, completed, pending }

@riverpod
class TodoCurrentFilter extends _$TodoCurrentFilter {
  @override
  FilterType build() => FilterType.all;

  void setCurrentFilter(FilterType filter) {
    state = filter;
  }
}

@riverpod
class TodosList extends _$TodosList {
  @override
  List<Todo> build() => [
        Todo(
            id: uuid.v4(),
            description: 'Buy groceries',
            completedAt: DateTime.now()),
        Todo(id: uuid.v4(), description: 'Buy groceries', completedAt: null),
        Todo(
            id: uuid.v4(),
            description: 'Buy groceries',
            completedAt: DateTime.now()),
      ];

  void toggleTodo(String id) {
    state = state.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(completedAt: todo.done ? null : DateTime.now());
      }
        return todo;
    }).toList();
  }

  void addTodo(String description) {
    final todo =
        Todo(id: uuid.v4(), description: description, completedAt: null);
    state = [...state, todo];
  }
}

@riverpod
List<Todo> filteredTodos (Ref ref) {
  final todos = ref.watch(todosListProvider);
  final filter = ref.watch(todoCurrentFilterProvider);

  switch (filter) {
    case FilterType.all:
      return todos;
    case FilterType.completed:
      return todos.where((todo) => todo.done).toList();
    case FilterType.pending:
      return todos.where((todo) => !todo.done).toList();
  }
}