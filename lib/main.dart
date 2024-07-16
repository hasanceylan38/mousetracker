import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pip_view/pip_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  AppLifecycleState _lastLifecycleState = AppLifecycleState.resumed;

  double x = 0.0;
  double y = 0.0;
  bool _tracking = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('App lifecycle state changed: $state');

    if (state == AppLifecycleState.paused) {
      print('Uygulama arka planda.');
    } else if (state == AppLifecycleState.inactive) {
      print('Uygulama inaktif.');
    } else if (state == AppLifecycleState.resumed) {
      print('Uygulama tekrar aktif.');
    }
  }

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
        print(
            "Mouse Position: (${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)})");
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
          child: SingleChildScrollView(
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
                const SizedBox(
                  height: 10,
                ),
                Text(
                    "Mouse Position: (${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)})"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
