// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: SafeArea(
          child: Column(
            children: <Widget>[
              TextButton.icon(onPressed: (){Navigator.pushNamed((context), '/location');}, icon: Icon(Icons.edit_location, color: Colors.grey.shade900,size: 30,),label: Text('Edit Location',style: TextStyle(color: Colors.grey.shade900,fontSize: 20,fontWeight: FontWeight.w400),), ),
            ],
          )
      ),
    );
  }
}
