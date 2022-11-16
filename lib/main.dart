import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:provider/provider.dart';
import 'package:xcards_admin_app/managers/device_manager.dart';
import 'package:xcards_admin_app/models/device/device_status.dart';
import 'package:xcards_admin_app/services/api_service.dart';

import 'context/auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: OneContext().builder,
      navigatorKey: OneContext().key,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<AuthProvider>.value(
          value: AuthProvider(),
          child: const MyHomePage(title: "xCards Admin App")
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    print('initState');
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            authProvider.isAuthenticated
              ? ElevatedButton(
                onPressed: authProvider.logout,
                child: const Text('Logout')
              ) : ElevatedButton(
                onPressed: authProvider.login,
                child: const Text('Login')
              ),
            authProvider.isAuthenticated
              ? ElevatedButton(
                onPressed: () => DeviceManager.getDevice(authProvider, 'item'),
                child: const Text('Get a device')
              ) : Container(),
            authProvider.isAuthenticated
                ? ElevatedButton(
                onPressed: () => DeviceManager.createDevice(authProvider, DeviceType.card),
                child: const Text('Create a device')
            ) : Container(),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
