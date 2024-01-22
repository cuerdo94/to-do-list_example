import 'package:example_form/modules/tasks/models/task.dart';
import 'package:example_form/widgets/input_task_widget.dart';
import 'package:flutter/material.dart';

class TaskListView extends StatefulWidget {
  static String routeName = "TaskListView";
  const TaskListView({super.key});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  List<Task> tasks = [];
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(tasks[index].title),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              setState(() {
                tasks.removeAt(index);
              });
            },
            child: ListTile(
              title: Text(
                tasks[index].title,
                style: TextStyle(
                  decoration: tasks[index].isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              leading: Checkbox(
                value: tasks[index].isCompleted,
                onChanged: (value) {
                  setState(() {
                    tasks[index].isCompleted = value!;
                  });
                },
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    tasks.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTask();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addTask() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
            insetPadding: EdgeInsets.zero,
            buttonPadding: EdgeInsets.zero,
            actionsPadding: EdgeInsets.zero,
            alignment: Alignment.bottomCenter,
            contentPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            iconPadding: EdgeInsets.zero,
            content: SizedBox(
                width: double.maxFinite,
                child: TaskModalWidget(
                    controller: _controller,
                    onPressed: () {
                      if (_controller.text.isEmpty) {
                        ScaffoldMessenger.of(context).showMaterialBanner(
                            MaterialBanner(
                                backgroundColor: Colors.red,
                                content: const Text(
                                    "Debe ingresar almenos un caracter"),
                                actions: [
                              TextButton(
                                  onPressed: () => ScaffoldMessenger.of(context)
                                      .hideCurrentMaterialBanner(),
                                  child: const Text("Cerrar"))
                            ]));
                        return false;
                      }
                      tasks.add(Task(_controller.text, false));
                      setState(() {});
                      _controller.clear();

                      Navigator.pop(context);
                    })));
      },
    );
  }
}
