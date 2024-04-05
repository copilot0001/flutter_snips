// This code creates a simple ListView with swipe-to-dismiss functionality.
// Each list item can be swiped from right to left to delete it.
// You can run this code in DartPad to see how it works.

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SwipeableWidget(),
    );
  }
}

class SwipeableWidget extends StatefulWidget {
  @override
  _SwipeableWidgetState createState() => _SwipeableWidgetState();
}

class _SwipeableWidgetState extends State<SwipeableWidget> {
  List<String> items = List.generate(10, (index) => "Item ${index + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swipeable Widget Example'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Dismissible(
            key: Key(item),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: Icon(Icons.delete, color: Colors.white),
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                items.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$item dismissed'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      setState(() {
                        items.insert(index, item);
                      });
                    },
                  ),
                ),
              );
            },
            child: ListTile(
              title: Text(item),
            ),
          );
        },
      ),
    );
  }
}
