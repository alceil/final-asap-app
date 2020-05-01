import 'package:cloud_firestore/cloud_firestore.dart';

class crudmethods
{
  Future <void> addData(carData) async{
    Firestore.instance.collection('testcrud').add(carData).catchError((e){print(e);});
  }
 getData() async
{
 return await Firestore.instance.collection('testcrud').getDocuments();
}
getData1() async
{
 return await Firestore.instance.collection('webinar').getDocuments();
}

updateData(selectedDoc,newValue)
{
  Firestore.instance.collection('testcrud').document(selectedDoc).updateData(newValue).catchError((e){print(e);});
}
deleteData(docId)
{
  Firestore.instance.collection('testcrud').document(docId).delete().catchError((e){print(e);});
}
}