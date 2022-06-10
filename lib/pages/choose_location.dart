// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        title: Text('Choose Location',style: TextStyle(color: Colors.amberAccent),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey.shade900,
      ),
      body: Text('locations page'),
    );
  }
}
