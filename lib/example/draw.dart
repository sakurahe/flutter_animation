import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Draw extends StatefulWidget {
  final String title;

  Draw({
    Key key,
    this.title = 'Draw',
  }) : super(key: key);
  @override
  _DrawState createState() => _DrawState();
}

class _DrawState extends State<Draw> {
  List<Offset> _points = <Offset>[];

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
    return Scaffold(
      appBar: appBar,
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onPanUpdate: (DragUpdateDetails details) {
              RenderBox referenceBox = context.findRenderObject();
              Offset localPosition =
                  referenceBox.globalToLocal(details.globalPosition);
              setState(() {
                _points = new List.from(_points)
                  ..add(Offset(
                      localPosition.dx,
                      localPosition.dy -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top));
              });
            },
            onPanEnd: (DragEndDetails details) => _points.add(null),
          ),
          CustomPaint(
            painter: new SignaturePainter(_points),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.clear),
        onPressed: reset,
      ),
    );
  }

  void reset() {
    setState(() {
      _points = [];
    });
  }
}

class SignaturePainter extends CustomPainter {
  final List<Offset> points;

  SignaturePainter(this.points);

  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8.0
      ..strokeJoin = StrokeJoin.bevel;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  bool shouldRepaint(SignaturePainter other) => other.points != points;
}
