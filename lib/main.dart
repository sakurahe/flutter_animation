import 'package:flutter/material.dart';
import 'package:animate_example/routes.dart';

import 'package:animate_example/example/shape_animate.dart';
import 'package:animate_example/example/draw.dart';
import 'package:animate_example/example/animate_demo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        Routes.home: (context) => MyHomePage(),
        Routes.shapeAnimate: (context) => ShapeAnimate(),
        Routes.draw: (context) => Draw(),
        Routes.animateDemo: (context) => AnimateDemo(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, String>> _list = [
    {'name': 'Shape Animate', 'path': Routes.shapeAnimate},
    {'name': 'Draw', 'path': Routes.draw},
    {'name': 'Animate Demo', 'path': Routes.animateDemo},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animate Exammple'),
      ),
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          final item = _list[index];
          return ListTile(
            onTap: () {
              Navigator.pushNamed(context, item['path']);
            },
            title: Text(item['name']),
          );
        },
      ),
    );
  }
}
