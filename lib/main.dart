import 'package:android/data/list_items.dart';
import 'package:android/widgets/list_item_widget.dart';
import 'package:flutter/material.dart';

import 'model/list_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final listKey = GlobalKey<AnimatedListState>();
  final List<ListItem> items = List.from(listItems);
  @override
  Widget build(BuildContext context) {
    void insertItem() {
      final newIndex = 1;
      final newItem = (List.of(listItems)..shuffle()).first;
      items.insert(newIndex, newItem);
      listKey.currentState!
          .insertItem(newIndex, duration: Duration(milliseconds: 600));
    }

    void removeItem(int index) {
      final removeItem = items[index];
      items.removeAt(index);
      listKey.currentState!.removeItem(
          index,
          (context, animation) => ListItemWidget(
              item: removeItem, animation: animation, onClicked: () {}),
          duration: Duration(milliseconds: 600));
    }

    return Scaffold(
      appBar: AppBar(title: Text("Animared List"), centerTitle: true),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          // Color(0xFF7BD5F5),
          Color(0xFF1CA7EC),
          Color(0xFF1F2F98),
          // Color(0xFF787FF6),
          // Color(0xFF4ADEDE),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: AnimatedList(
            key: listKey,
            initialItemCount: items.length,
            itemBuilder: (context, index, animation) => ListItemWidget(
                  item: items[index],
                  animation: animation,
                  onClicked: () => removeItem(index),
                )),
      ),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: insertItem),
    );
  }
}
