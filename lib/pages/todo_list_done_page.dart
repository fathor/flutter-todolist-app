import 'package:flutter/material.dart';
import 'package:todolist_app/widgets/item_widget.dart';

import '../models/todo_item.dart';
import '../utils/network_manager.dart';

class TodoDonePagae extends StatefulWidget {
  const TodoDonePagae({super.key});

  @override
  State<TodoDonePagae> createState() => _TodoDonePagaeState();
}

class _TodoDonePagaeState extends State<TodoDonePagae> {
  List<TodoItem> todos = [];
  bool isLoading = false;

  void refreshData() {
    setState(() {
      isLoading = true;
    });
    NetworkManager().getTodosIsDone(true).then((value) {
      todos = value;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List App Done"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Todo Is Done",
                  style: textTheme.bodyText1,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return ItemWidget(
                    todoItem: todos[index],
                    handleRefresh: refreshData,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
