import 'package:asap_app/screens/asapscreen.dart';
import 'package:asap_app/screens/tabsscreen.dart';
import 'package:asap_app/screens/testscreen.dart';
import 'package:asap_app/widget/local_notification.dart';
import 'package:asap_app/widget/newpage.dart';
import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:Home()
    );
  }
}



