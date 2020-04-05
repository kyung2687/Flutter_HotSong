import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


int index = 0;

 class MyHomePage extends StatefulWidget {
 @override
 _MyHomePageState createState() {
   return _MyHomePageState();
 }
}

class _MyHomePageState extends State<MyHomePage> {
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: Text('Baby Name Votes')),
     body: _buildBody(context),
   );
 }

Widget _buildBody(BuildContext context) {
 return StreamBuilder<QuerySnapshot>(
   stream: Firestore.instance.collection('songdb').snapshots(),
   builder: (context, snapshot) {
     if (!snapshot.hasData) return LinearProgressIndicator();

     return _buildList(context, snapshot.data.documents);
   },
 );
}

 Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
   return ListView(
     padding: const EdgeInsets.only(top: 20.0),
     children: snapshot.map((data) => _buildListItem(context, data)).toList(),
   );
 }

 Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
   final record = Record.fromSnapshot(data);
   index++;
   return Padding(
     key: ValueKey(record.title),
     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
     child: Container(
       decoration: BoxDecoration(
         border: Border.all(color: Colors.grey),
         borderRadius: BorderRadius.circular(5.0),
       ),
       child: ListTile(
         title: Text(index.toString() + " " + record.title + " - " + record.singer),
         subtitle: Text('   [' + record.sin_com + '] ' + record.sin_user + ' ' + record.sin_rank),
         trailing: Text(record.like.toString()),
         onTap: () => record.reference.updateData({'like': FieldValue.increment(1)}),
       ),
     ),
   );
 }
}

class Record {
 final String title;
 final String singer;
 final String sin_user;
 final String sin_com;
 final String sin_rank;
 final String sin_date;
 final String str_date;
 final bool strYN;
 final int like;

 final DocumentReference reference;

 Record.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['title'] != null),
       assert(map['singer'] != null),
       assert(map['sin_user'] != null),
       assert(map['sin_com'] != null),
       assert(map['sin_rank'] != null),
       assert(map['sin_date'] != null),
       assert(map['str_date'] != null),
       assert(map['strYN'] != null),
       assert(map['like'] != null),
       
       title    = map['title'],
       singer   = map['singer'],
       sin_user = map['sin_user'],
       sin_com  = map['sin_com'],
       sin_rank = map['sin_rank'],
       sin_date = map['sin_date'].toString(),
       str_date = map['str_date'].toString(),
       strYN    = map['strYN'],
       like     = map['like'];

 Record.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 @override
 String toString() => "Record<$title:$singer>";
}