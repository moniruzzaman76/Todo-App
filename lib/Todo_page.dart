
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> todos = [];
  TextEditingController todoNameEditingController = TextEditingController();
  TextEditingController updateTodoNameEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Todo Name'),
                        const SizedBox(height: 16),
                        TextField(
                          controller: todoNameEditingController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your new todo',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                            onPressed: () {
                              if (todoNameEditingController.text.trim().isNotEmpty) {
                                todos.add(todoNameEditingController.text.trim());
                                todoNameEditingController.text = '';
                                setState(() {});
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Add Task'))
                      ],
                    ),
                  );
                });
          },
          label: const Text('Add')),
      body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final String todo = todos[(todos.length - 1) - index];
            return Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Row(
                    children: [
                      Text(todo, style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 16),
                      ),

                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            todos.removeAt((todos.length - 1) - index);
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),

                      IconButton(
                          onPressed: () {
                            updateTodoNameEditingController.text = todo;
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('Update todo name'),

                                        const SizedBox(height: 16),
                                        TextField(
                                          controller: updateTodoNameEditingController,
                                          decoration: const InputDecoration(
                                            hintText: 'Enter your new todo',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        ElevatedButton(
                                            onPressed: () {
                                              if (updateTodoNameEditingController.text.trim().isNotEmpty) {
                                                todos[(todos.length - 1) - index] =
                                                    updateTodoNameEditingController.text.trim();
                                                setState(() {});
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: const Text('Update Task'))
                                      ],
                                    ),
                                  );
                                });
                          },

                          icon: const Icon(
                            Icons.edit,
                            color: Colors.amber,
                          ))
                    ],
                  ),
                ));
          }),
    );
  }
}