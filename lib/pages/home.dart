// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  late String bgImg;
  late Color bgColor;
  late Color fontColor;

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty? data: ModalRoute.of(context)?.settings.arguments as Map;
    if(data['isDay']!=null){
      bgImg = data['isDay'] ? 'day.jpg':'night.jpg'; //setting background image
      bgColor = data['isDay'] ? Colors.blue.shade300 : Colors.grey.shade900;//setting background colour
      fontColor = data['isDay'] ? Colors.grey.shade900:Colors.grey.shade700;//setting font color
    }

    return Scaffold(
      backgroundColor:bgColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/$bgImg'),fit: BoxFit.cover ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
              child: Column(
                children: <Widget>[
                  TextButton.icon(onPressed: ()async{
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    if(result != null){
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isDay': result['isDay'],
                          'flag': result['flag']
                        };
                      });
                    }
                    },
                    icon: Icon(Icons.edit_location, color:fontColor,size: 30,),
                    label: Text('Edit Location',style: TextStyle(color: fontColor,fontSize: 20,fontWeight: FontWeight.w400),), ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          data['location']!,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 28,
                            letterSpacing: 2.0,
                            color: fontColor,
                          ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text(
                    data['time']!,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 58,
                      letterSpacing: 2.0,
                      color: Colors.amber,
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
