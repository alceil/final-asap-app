import 'package:asap_app/services/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class testscreen extends StatefulWidget {
  @override
  _testscreenState createState() => _testscreenState();
}

class _testscreenState extends State<testscreen> {
  String carModel;
  String carColour;
  QuerySnapshot cars;
  crudmethods crudObj = crudmethods();
  Future<bool> addDialog(BuildContext context) async
  {
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog
            (
            title: Text('Add Data', style: TextStyle(fontSize: 15.0),),
            content: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: 'Enter car Name'),
                  onChanged: (value) {
                    this.carModel = value;
                  },
                ),
                SizedBox(height: 5.0,),
                TextField(
                  decoration: InputDecoration(hintText: 'Enter car colour'),
                  onChanged: (value) {
                    this.carColour = value;
                  },
                ),
              ],
            ),
            actions: <Widget>
            [
              FlatButton
                (
                child: Text('Add'),
                onPressed: () {
                  Navigator.of(context).pop();
                  crudObj.addData({
                    'carName': this.carModel,
                    'color': this.carColour
                  }).then((result) {
                    dialogTrigger(context);
                  }).catchError((e) {
                    print(e);
                  });
                },
              )
            ],
          );
        });
  }
  Future<bool> updateDialog(BuildContext context,selectedDoc) async
  {
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog
            (
            title: Text('Add Data', style: TextStyle(fontSize: 15.0),),
            content: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: 'Enter car Name'),
                  onChanged: (value) {
                    this.carModel = value;
                  },
                ),
                SizedBox(height: 5.0,),
                TextField(
                  decoration: InputDecoration(hintText: 'Enter car colour'),
                  onChanged: (value) {
                    this.carColour = value;
                  },
                ),
              ],
            ),
            actions: <Widget>
            [
              FlatButton
                (
                child: Text('Update'),
                onPressed: () {
                  Navigator.of(context).pop();
                  crudObj.updateData(selectedDoc,{
                    'carName': this.carModel,
                    'color': this.carColour
                  }).then((result) {
                    //dialogTrigger(context);
                  }).catchError((e) {
                    print(e);
                  });
                },
              )
            ],
          );
        });
  }
  Future<bool> dialogTrigger(BuildContext context) async
  {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context)
        {
          return AlertDialog(
            title:Text('Job done',style: TextStyle(fontSize: 15.0),) ,
            content: Text('Added'),
            actions: <Widget>
            [
              FlatButton(
                child: Text('Alright'),
                textColor: Colors.blue,
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }
@override
  void initState() {
  crudObj.getData().then((results){
    setState(() {
      cars=results;
    });
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crud app'),
        actions: <Widget>
        [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              addDialog(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (){
              crudObj.getData().then((results){
                setState(() {
                  cars=results;
                });
              });
            },
          ),
        ],
      ),
      body: _carList(),
    );
  }
  Widget _carList()
  {
    if(cars!=null)
      {
        return StreamBuilder(
          stream:Firestore.instance.collection('testcrud').snapshots(),
          builder:(context,snapshot)
          {
            return ListView.builder(itemCount: snapshot.data.documents.length,itemBuilder: (context,i)
            {
              return ListTile(
                title: Text(snapshot.data.documents[i].data['carName']),
                subtitle: Text(snapshot.data.documents[i].data['color']),
                onTap: (){updateDialog(context, snapshot.data.documents[i].documentID);},
                onLongPress: (){
                  crudObj.deleteData(snapshot.data.documents[i].documentID);
                },
              );
            }
            );

          },


          );
      }
    else
      {
        return Text('Loadind please wait');
      }
  }
}
