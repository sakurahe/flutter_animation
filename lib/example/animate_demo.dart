import 'dart:math';

import 'package:flutter/material.dart';

class MoveBox {
  double x; // 初始x轴位置
  double y; // 初始y轴位置
  double speedX; // x速度
  double speedY; // y速度
  double block; // 移动盒子大小
  Color color; // 盒子颜色

  MoveBox({this.x, this.y, this.speedX, this.speedY, this.block, this.color});
}

class AnimateDemo extends StatefulWidget {
  final String title;

  AnimateDemo({
    Key key,
    this.title = 'Animate Demo',
  }) : super(key: key);
  @override
  _AnimateDemoState createState() => _AnimateDemoState();
}

class _AnimateDemoState extends State<AnimateDemo>
    with TickerProviderStateMixin {
  AnimationController controller;
  double _width = 0.0; // 设备宽
  double _height = 0.0; // 设备高
  MoveBox moveBox = MoveBox(
    x: 0.0,
    y: 0.0,
    speedX: 2.0,
    speedY: -2.0,
    block: 24.0,
    color: Colors.blue,
  );

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200000),
    );
    controller.addListener(() {
      moveBox.x += moveBox.speedX;
      moveBox.y += moveBox.speedY;
      // 限定下边界
      if (moveBox.y > _height - moveBox.block) {
        moveBox.y = _height - moveBox.block;
        moveBox.speedY = -moveBox.speedY;
        randomColor();
      }
      // 限定上边界
      if (moveBox.y < 0) {
        moveBox.y = 0;
        moveBox.speedY = -moveBox.speedY;
        randomColor();
      }
      // 限定左边界
      if (moveBox.x < 0) {
        moveBox.x = 0;
        moveBox.speedX = -moveBox.speedX;
        randomColor();
      }
      // 限定右边界
      if (moveBox.x > _width - moveBox.block) {
        moveBox.x = _width - moveBox.block;
        moveBox.speedX = -moveBox.speedX;
        randomColor();
      }
      // print('bottom:${_height - moveBox.block},x:${moveBox.x},y:${moveBox.y}');
      setState(() {});
    });

    controller.forward();
  }

  void randomColor() {
    final random = Random();
    moveBox.color = Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      centerTitle: true,
      title: Text(widget.title),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _height = MediaQuery.of(context).size.height -
          appBar.preferredSize.height -
          MediaQuery.of(context).padding.top;
    });
    return Scaffold(
      appBar: appBar,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: moveBox.y,
            left: moveBox.x,
            child: Container(
              width: moveBox.block,
              height: moveBox.block,
              decoration: BoxDecoration(
                color: moveBox.color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
