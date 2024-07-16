import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mouse Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage1(),
    );
  }
}

class MyHomePage1 extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage1> {
  double x = 0.0;
  double y = 0.0;
  bool _tracking = true;

  void _updateLocation(PointerEvent details) {
    if (_tracking) {
      setState(() {
        x = details.position.dx;
        y = details.position.dy;
        print(
            " Mouse Position: (${x.toStringAsFixed(2)},${y.toStringAsFixed(2)})");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mouse Tracker'),
      ),
      body: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerHover: _updateLocation,
        onPointerMove: _updateLocation,
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    "Mouse Position: (${x.toStringAsFixed(2)},${y.toStringAsFixed(2)})"),
              ]),
        ),
      ),
    );
  }
}
