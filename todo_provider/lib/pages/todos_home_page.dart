import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/providers/providers.dart';

import '../models/todo_model.dart';
import '../utils/debounce.dart';

class ToDoHomePage extends StatefulWidget {
  const ToDoHomePage({super.key});

  @override
  State<ToDoHomePage> createState() => _ToDoHomePageState();
}

class _ToDoHomePageState extends State<ToDoHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 40,
              ),
              child: Column(
                children: [
                  const ToDoHeader(),
                  const CreateToDo(),
                  const SizedBox(
                    height: 20,
                  ),
                  SearchAndFilterToDo(),
                  const SizedBox(
                    height: 20,
                  ),
                  const ShowToDos(),
                ],
              )),
        ),
      ),
    );
  }
}

class ToDoHeader extends StatelessWidget {
  const ToDoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    int activeToDoCount =
        context.watch<ActiveToDoCount>().state.activeToDoCount;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'TODO',
          style: TextStyle(
            fontSize: 40,
          ),
        ),
        Text(
          '$activeToDoCount items left',
          style: const TextStyle(
            fontSize: 25,
            color: Colors.redAccent,
          ),
        )
      ],
    );
  }
}

class CreateToDo extends StatefulWidget {
  const CreateToDo({super.key});

  @override
  State<CreateToDo> createState() => _CreateToDoState();
}

class _CreateToDoState extends State<CreateToDo> {
  final newToDoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: newToDoController,
      decoration: const InputDecoration(
        labelText: 'Add a new todo',
      ),
      onSubmitted: (String? toDoDesc) {
        if (toDoDesc != null && toDoDesc.trim().isNotEmpty) {
          context.read<ToDoList>().addNewToDo(toDoDesc);
          newToDoController.clear();
        }
      },
    );
  }

  @override
  void dispose() {
    newToDoController.dispose();
    super.dispose();
  }
}

class SearchAndFilterToDo extends StatelessWidget {
  SearchAndFilterToDo({super.key});
  final debounce = Debounce();

  @override
  Widget build(BuildContext context) {
    ToDoSearch toDoSearch = context.read<ToDoSearch>();
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Search todos',
            border: InputBorder.none,
            filled: true,
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (String? newSearchTerm) {
            if (newSearchTerm != null) {
              debounce.run(
                () {
                  toDoSearch.setSearchTerm(newSearchTerm);
                },
              );
            }
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filterButton(context, Filter.all),
            filterButton(context, Filter.active),
            filterButton(context, Filter.completed),
          ],
        )
      ],
    );
  }

  Widget filterButton(BuildContext context, Filter filter) {
    String filterText = switch (filter) {
      Filter.all => 'All',
      Filter.active => 'Active',
      Filter.completed => 'Completed',
    };

    return TextButton(
      onPressed: () {
        context.read<ToDoFilter>().changeFilter(filter);
      },
      child: Text(
        filterText,
        style: TextStyle(
          fontSize: 18,
          color: textColor(context, filter),
        ),
      ),
    );
  }

  Color textColor(BuildContext context, Filter filter) {
    final currentFilter = context.watch<ToDoFilter>().state.filter;

    return currentFilter == filter ? Colors.blueAccent : Colors.grey;
  }
}

class ShowToDos extends StatelessWidget {
  const ShowToDos({super.key});

  Widget showBackground(int direction) {
    return Container(
      margin: const EdgeInsets.all(
        4,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        size: 30,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final toDosFiltered = context.watch<FilteredToDos>().state.filteredToDos;
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemCount: toDosFiltered.length,
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.grey,
        );
      },
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(toDosFiltered[index].id),
          background: showBackground(0),
          secondaryBackground: showBackground(1),
          child: ToDoItem(
            toDoItem: toDosFiltered[index],
          ),
          onDismissed: (_) {
            context.read<ToDoList>().removeToDo(
                  toDosFiltered[index],
                );
          },
          confirmDismiss: (_) {
            return showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Are you sure?'),
                  content: const Text('Deleting an item is permanent'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(
                        context,
                        false,
                      ),
                      child: const Text('NO'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(
                        context,
                        true,
                      ),
                      child: const Text('YES'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}

class ToDoItem extends StatefulWidget {
  const ToDoItem({
    super.key,
    required this.toDoItem,
  });

  final ToDo toDoItem;

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            bool _error = false;
            textController.text = widget.toDoItem.desc;

            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: const Text('Edit ToDo'),
                  content: TextField(
                    controller: textController,
                    autofocus: true,
                    decoration: InputDecoration(
                        errorText: _error ? 'Value cannot be empty' : null),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('CANCEL'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(
                          () {
                            _error = textController.text.isEmpty ? true : false;

                            if (!_error) {
                              context.read<ToDoList>().changeToDoDesc(
                                    widget.toDoItem.id,
                                    textController.text,
                                  );
                              Navigator.pop(context);
                            }
                          },
                        );
                      },
                      child: const Text('EDIT'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      title: Text(widget.toDoItem.desc),
      leading: Checkbox(
        value: widget.toDoItem.isCompleted,
        onChanged: (bool? isChecked) {
          if (isChecked != null) {
            context.read<ToDoList>().toggleToDo(widget.toDoItem.id);
          }
        },
      ),
    );
  }
}
