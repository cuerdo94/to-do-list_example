import 'package:example_form/modules/tasks/views/list_to_do_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        initialRoute: TaskListView.routeName,
        routes: {TaskListView.routeName: (_) => const TaskListView()});
  }
}
