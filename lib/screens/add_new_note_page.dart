import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // For kDebugMode

// Custom logging function
void logMessage(String message) {
  if (kDebugMode) {
    print(message); // Only print messages in debug mode
  }
}

class AddNewNotePage extends StatelessWidget {
  const AddNewNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Note')),
      body: const Center(child: Text('Add New Note Page')),
    );
  }
}

class CreateTodoScreen extends StatefulWidget {
  const CreateTodoScreen({Key? key}) : super(key: key);

  @override
  CreateTodoScreenState createState() => CreateTodoScreenState();
}

class CreateTodoScreenState extends State<CreateTodoScreen> {
  List<String> todoList = ["Todo..", "Todo.."];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController todoController = TextEditingController();
  Color selectedColor = Colors.lightGreen;

  void addTodo() {
    setState(() {
      todoList.add("New Todo notes");
    });
  }

  void removeTodoAt(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  void editTodoAt(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController editController =
            TextEditingController(text: todoList[index]);
        return AlertDialog(
          title: const Text("Edit Notes"),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(
              hintText: "Update Notes",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  todoList[index] = editController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void saveTodoList() {
    String title = titleController.text;
    logMessage("Title: $title");
    logMessage("Simple Notes App: $todoList");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Todos saved successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedColor,
      appBar: AppBar(
        backgroundColor: selectedColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: Colors.black),
            onPressed: saveTodoList,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                hintText: "Title",
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: GestureDetector(
                      onTap: () {
                        editTodoAt(index);
                      },
                      child: Text(todoList[index]),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        removeTodoAt(index);
                      },
                    ),
                  );
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Add todo"),
              onTap: addTodo,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: todoController,
              decoration: const InputDecoration(
                hintText: "Type something...",
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(7, (index) {
                  Color color;
                  switch (index) {
                    case 0:
                      color = Colors.greenAccent;
                      break;
                    case 1:
                      color = Colors.blueAccent;
                      break;
                    case 2:
                      color = Colors.purpleAccent;
                      break;
                    case 3:
                      color = Colors.orangeAccent;
                      break;
                    case 4:
                      color = Colors.yellowAccent;
                      break;
                    case 5:
                      color = Colors.pinkAccent;
                      break;
                    case 6:
                      color = Colors.cyanAccent;
                      break;
                    default:
                      color = Colors.lightGreen;
                  }
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: color,
                      child: selectedColor == color
                          ? const Icon(Icons.check, color: Colors.white)
                          : null,
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
