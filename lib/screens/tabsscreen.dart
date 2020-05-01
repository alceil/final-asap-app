import 'package:asap_app/screens/asapscreen.dart';
import 'package:asap_app/screens/webinar.dart';
import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
return DefaultTabController
(
  length: 2,
  initialIndex: 0, 
  child: Scaffold
(
   appBar: AppBar(
        title: Text('Skillet',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        elevation: 5.0,
        backgroundColor: Colors.blue,
        actions: <Widget>[

        ],
        bottom: TabBar
        (tabs: <Widget>
        [
          Tab(text:'Classes',),
          Tab(text:'Webinar'),
        ]
        ),
      ),
      body: TabBarView
      (
        children: <Widget>
        [
          Class(),
          Webinar(),

        ]
        ),
)
  );
  }
}