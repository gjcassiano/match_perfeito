import 'package:flutter/material.dart';
import 'home/home.view.dart';
import 'login/login.view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Match Perfeito',
            theme: ThemeData(primarySwatch: Colors.blue),
            // home: LoginManagerScreen() //
            home: MyHomePage(title: 'Match Perfeito')
        );
    }
}
