import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Bu satırı ekleyin
import 'package:flutter_application_2/back1.dart';
import 'package:pip_view/pip_view.dart';

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
      home: PIPView(
        builder: (context, isFloating) {
          return MyHomePage();
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double x = 0.0;
  double y = 0.0;
  bool _tracking = false;

  void _startTracking() {
    setState(() {
      _tracking = true;
    });
  }

  void _stopTracking() {
    setState(() {
      _tracking = false;
    });
  }

  void _updateLocation(PointerEvent details) {
    if (_tracking) {
      setState(() {
        x = details.position.dx;
        y = details.position.dy;
        print("Mouse Position: (${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)})");
      });
    }
  }

  void _enterPipMode() {
    if (Theme.of(context).platform == TargetPlatform.android) {
      
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      
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
              Container(
                height: 40,
                width: 100,
                child: ElevatedButton(
                  onPressed: _startTracking,
                  child: Text('Start'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: 100,
                child: ElevatedButton(
                  onPressed: _stopTracking,
                  child: Text('Stop'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                onPressed: () {
                  PIPView.of(context)?.presentBelow(MyHomePage1());
                },
                child: Icon(Icons.picture_in_picture),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: 100,
                child: ElevatedButton(
                  onPressed: _enterPipMode,
                  child: Text('Enter PiP'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text("Mouse Position: (${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)})"),
            ],
          ),
        ),
      ),
    );
  }
}


