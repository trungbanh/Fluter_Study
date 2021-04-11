import 'package:flutter/material.dart';

import 'Detail.dart';
import 'Home.dart';
import 'Login.dart';
import 'Routers.dart';

void main() {
  runApp(MyApp());
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
            builder: (_) => MyHomePage(title: 'Flutter Demo Home Page'));
      case loginRoute:
        return MaterialPageRoute(builder: (_) => Login());
      case detailRoute:
        var data = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => Detail(data));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: Router.generateRoute,
      initialRoute: homeRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
