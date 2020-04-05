import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
 @override
 _SigninPageState createState() {
   return _SigninPageState();
 }
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _id = new TextEditingController();
  TextEditingController _pw = TextEditingController();

 @override
 Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.purple,
    body: _buildTextComposer(),
  );
 }

 Widget _buildTextComposer() {
   return 
   new Center(
   child: new Container(
     decoration: BoxDecoration(
       color: Colors.white,
       boxShadow: [
        BoxShadow(
          color: Colors.black38,
          blurRadius: 20.0, // has the effect of softening the shadow
          spreadRadius: 0.1, // has the effect of extending the shadow
          offset: Offset(
            5.0, // horizontal, move right 10
            5.0, // vertical, move down 10
          ),
        )
      ],
     ),
     width: 400,
     height: 300,
     child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Container(
              alignment: Alignment(0.0, 0.0),
              height: 45,
              margin: EdgeInsets.only(left: 30, right: 30, top: 15),
              padding: EdgeInsets.only(left: 20, right: 20),
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(width: 1, color: Colors.black12),
              ),
              child: Row(children: <Widget>[
                Container(
                  width: 60,
                  child: Text("ID",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                ),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    child: TextField(
                      controller: _id,
                      style: TextStyle(color:Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Input Your Id',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                      cursorColor: Colors.blue,
                    ),
                  ),
                )
              ],)
            )
          ),
          Flexible(
            child: Container(
              alignment: Alignment(0.0, 0.0),
              height: 45,
              margin: EdgeInsets.only(left: 30, right: 30, top: 15),
              padding: EdgeInsets.only(left: 20, right: 20),
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(width: 1, color: Colors.black12),
              ),
              child: Row(children: <Widget>[
                Container(
                  width: 60,
                  child: Text("PW",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                ),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    child: TextField(
                      controller: _pw,
                      style: TextStyle(color:Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Input Your PW',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                      cursorColor: Colors.blue,
                    ),
                  ),
                )
              ],)
            )
          ),
          Flexible(
            child: Container(
              alignment: Alignment(0.0, 0.0),
              height: 45,
              margin: EdgeInsets.only(left: 30, right: 30, top: 15),
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(width: 1, color: Colors.black12),
              ),
              child: SizedBox.expand(
                child: RaisedButton(
                  child: Text("LOGIN"),
                  onPressed: () => _handleSubmitted("asd"),
                  color: Colors.purple,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(10.0),
                  splashColor: Colors.grey,
                ),
              )
            )
          ),
        ],
     ),
   )
   );
 }
  void _handleSubmitted(String text) async {
    QuerySnapshot snapshot = await Firestore.instance.collection('userdb').getDocuments();
    final user = User.fromSnapshot(snapshot.documents.first);
    print(user.name);
  }
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('userdb').snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) return LinearProgressIndicator();
        if(snapshot.hasError) return new Text('Error: ${snapshot.error}');
        return _showDocument(context, snapshot.data.documents);
      },
    );
  }

  Widget _showDocument(BuildContext context, List<DocumentSnapshot> snapshot) {
    final data = User.fromSnapshot(snapshot.first);
    return Center(
      child: Text(data.task)
    );
  }
}

class User {
 final String name;
 final String id;
 final String pw;
 final String com;
 final String rank;
 final String task;

 final DocumentReference reference;

 User.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['name'] != null),
       assert(map['id'] != null),
       assert(map['pw'] != null),
       assert(map['com'] != null),
       assert(map['rank'] != null),
       assert(map['task'] != null),
       
       name  = map['name'],
       id    = map['id'],
       pw    = map['pw'],
       com   = map['com'],
       rank  = map['rank'],
       task  = map['task'];
       

 User.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 @override
 String toString() => "Record<$name:$id>";
}