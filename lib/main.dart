import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import './sinlist.dart';
import './signin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'Baby Names',
     home: SigninPage(),
   );
 }
}