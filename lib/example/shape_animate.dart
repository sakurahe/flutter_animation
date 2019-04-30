import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShapeAnimate extends StatefulWidget {
  final String title;

  ShapeAnimate({
    Key key,
    this.title = 'Shape Animate',
  }) : super(key: key);
  @override
  _ShapeAnimateState createState() => _ShapeAnimateState();
}

class _ShapeAnimateState extends State<ShapeAnimate> {
  double _width = 50;
  double _height = 50;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: AnimatedContainer(
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            color: _color,
            borderRadius: _borderRadius,
          ),
          duration: Duration(
            seconds: 1,
          ),
          curve: Curves.fastOutSlowIn,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: onChange,
      ),
    );
  }

  void onChange() {
    setState(() {
      final random = Random();

      _width = random.nextInt(300).toDouble();
      _height = random.nextInt(300).toDouble();

      _color = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      );

      _borderRadius = BorderRadius.circular(random.nextInt(100).toDouble());
    });
  }
}
