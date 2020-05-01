import 'dart:ffi';

import 'package:asap_app/services/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class Webinar extends StatefulWidget {
  @override
  _WebinarState createState() => _WebinarState();
}

class _WebinarState extends State<Webinar> {
  crudmethods crudObj = crudmethods();
  QuerySnapshot cars;
  Future<Void> _launchURL() async {
  String url = 'https://flutter.dev';
  if (await canLaunch(url)) {
    await launch(url,forceWebView: true,forceSafariVC: false,headers: <String,String>{'header_key':'header_value'});
  } else {
    throw 'Could not launch $url';
  }
}
  Widget _getlist()
  {
    if(cars!=null)
    {
       return Column(
        children: <Widget>
        [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text('Webinar Series',style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold)),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Classes',style:TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 10,),
          Expanded(
                      child: Container(
              color: Colors.white,
              child: StreamBuilder(
                stream:Firestore.instance.collection('webinar').snapshots(),
                builder: (context,snapshot)
                {
                 return  snapshot.hasData?ListView.builder(
                   scrollDirection: Axis.vertical,
                   shrinkWrap: true,
                   physics: ScrollPhysics(),
                    
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context,i)
                      {
                        return Container(
                          margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 10.0),
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0,1.0),
                                    blurRadius: 6.0
                                )
                              ]
                          ),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 10,),
                              ClipRect(
                                child:Image(
                                  height: 150,
                                  width: 110,
                                  image: NetworkImage(snapshot.data.documents[i].data['imgurl'].toString()),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                                              child: Column(
                                  children: <Widget>[
                    SizedBox(height: 20,),
                                    Row
                                    (
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>
                                      [
                                        Text('Instructor',style: TextStyle(fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                     SizedBox(height: 3,),
                                    Text('${snapshot.data.documents[i].data['subject']}'),
                                    SizedBox(height: 10,),
                                    Row
                                    (
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>
                                      [
                                        Text('Topic',style: TextStyle(fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                     SizedBox(height: 3,),
                                    Text('${snapshot.data.documents[i].data['topic']}'),
                                     SizedBox(height: 10,),
                                    // Row
                                    // (
                                    //   children: <Widget>
                                    //   [
                                    // SizedBox(width: 20.0,),    
                                    // Text('Module-${snapshot.data.documents[i].data['mno']}'),
                                    // SizedBox(width: 20.0,),
                                    // Text('Semister-${snapshot.data.documents[i].data['sno']}'),
                                    //   ],

                                    // ),
                                    // SizedBox(height: 5.0,),
                                    // Text('By ${snapshot.data.documents[i].data['instructor']}'),
                                    // SizedBox(height: 5.0,),
                                    // Text('Dept:${snapshot.data.documents[i].data['dept']}'),
                                    // Text('On ${snapshot.data.documents[i].data['date']}'),
                                    Row
                                    (
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>
                                      [
                                        Text('Time',style: TextStyle(fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                     SizedBox(height: 3,),
                                    Container(
                                      width:130,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(20.0)
                                      ),
                                      child: Center(child: Text('${snapshot.data.documents[i].data['stime']} - ${snapshot.data.documents[i].data['etime']}')),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }
                  ):Container
      (
        child: Center(child: CircularProgressIndicator()),
      );

                },
              )
            ),
          )


        ],
      );
    }
    else
    {
      return Container
      (
        child: Center(child: CircularProgressIndicator(),),
      );
    }
  }
  // Widget image_carousel = Container(
  //     height:200,
  //     child: Carousel(
  //       boxFit: BoxFit.cover,
  //       images:
  //       [
  //         AssetImage('assets/web1.png'),
  //         AssetImage('assets/webinar2.png'),

  //       ],
  //       autoplay: false,
  //       animationCurve:Curves.fastOutSlowIn,
  //       animationDuration: Duration(milliseconds: 1000),
  //     ),
  //   );
  @override
  void initState() {
    crudObj.getData1().then((results)
    {
      setState(() {
        cars = results;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('ASAP',style: TextStyle(color: Colors.black),),
      //   centerTitle: true,
      //   backgroundColor: Colors.blue,
      //   actions: <Widget>[
      //   ],
      // ),
      body:cars==null?Container
      (
        child: Center(child: CircularProgressIndicator(),),
      ):Column(
        children: <Widget>
        [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text('Webinar Series',style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold)),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text('Webinar',style:TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
          // ),
           Column(
             children: <Widget>[
               SizedBox(width: 20,),
               Text('Visit the website to watch the  videos',style: TextStyle(fontWeight: FontWeight.bold),),
               SizedBox(height: 3,),
              //  Container(
              //                         width:130,
              //                         decoration: BoxDecoration(
              //                             color: Colors.blue,
              //                         ),
              //                         child: Center(child: Text('Visit')),
              //                       ),
               FlatButton.icon(
                 
                 color: Colors.green,
                            onPressed:_launchURL,
                            icon: Icon(Icons.open_in_new, color: Colors.white),
                            label: Text(
                              "Visit",
                              style: TextStyle(color: Colors.white),
                            )),
             ],
           ),
          SizedBox(height: 5,),
          Expanded(
                      child: Container(
              color: Colors.white,
              child: StreamBuilder(
                stream:Firestore.instance.collection('webinar').snapshots(),
                builder: (context,snapshot)
                {
                 return snapshot.hasData?ListView.builder(
                   scrollDirection: Axis.vertical,
                   shrinkWrap: true,
                   physics: ScrollPhysics(),
                    
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context,i)
                      {
                        return Container(
                          margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 10.0),
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0,1.0),
                                    blurRadius: 6.0
                                )
                              ]
                          ),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 10,),
                              ClipRect(
                                child:Image(
                                  height: 150,
                                  width: 110,
                                  image: NetworkImage(snapshot.data.documents[i].data['imgurl'].toString()),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                                              child: Column(
                                  children: <Widget>[
                    SizedBox(height: 20,),
                                    Row
                                    (
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>
                                      [
                                        Text('Instructor',style: TextStyle(fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                     SizedBox(height: 3,),
                                    Text('${snapshot.data.documents[i].data['subject']}'),
                                    SizedBox(height: 10,),
                                    Row
                                    (
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>
                                      [
                                        Text('Topic',style: TextStyle(fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                     SizedBox(height: 3,),
                                    Text('${snapshot.data.documents[i].data['topic']}'),
                                     SizedBox(height: 10,),
                                    // Row
                                    // (
                                    //   children: <Widget>
                                    //   [
                                    // SizedBox(width: 20.0,),    
                                    // Text('Module-${snapshot.data.documents[i].data['mno']}'),
                                    // SizedBox(width: 20.0,),
                                    // Text('Semister-${snapshot.data.documents[i].data['sno']}'),
                                    //   ],

                                    // ),
                                    // SizedBox(height: 5.0,),
                                    // Text('By ${snapshot.data.documents[i].data['instructor']}'),
                                    // SizedBox(height: 5.0,),
                                    // Text('Dept:${snapshot.data.documents[i].data['dept']}'),
                                    // Text('On ${snapshot.data.documents[i].data['date']}'),
                                    Row
                                    (
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>
                                      [
                                        Text('Time',style: TextStyle(fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                     SizedBox(height: 3,),
                                    Container(
                                      width:130,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(20.0)
                                      ),
                                      child: Center(child: Text('${snapshot.data.documents[i].data['stime']} - ${snapshot.data.documents[i].data['etime']}')),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }
                  ):Container(child:Center(child: CircularProgressIndicator(),));

                },
              )
            ),
          ),
          
          

        ],
      )
    );
    }
}
