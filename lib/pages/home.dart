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
  late Color timeColor;

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty? data: ModalRoute.of(context)?.settings.arguments as Map;
    if(data['isDay']!=null){
      bgImg = data['isDay'] ? 'day.jpg':'night.jpg'; //setting background image
      bgColor = data['isDay'] ? Colors.blue.shade300 : Colors.grey.shade900;//setting background colour
      fontColor = data['isDay'] ? Colors.grey.shade900:Colors.grey.shade700;//setting font color
      timeColor = data['isDay'] ? Colors.grey.shade800:Colors.amber;//setting font color
    }

    return Scaffold(
      backgroundColor:bgColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/$bgImg'),fit: BoxFit.cover ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
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
                          'flag': result['flag'],
                          'dayOfWeek':result['dayOfWeek'],
                          'dayOfYear':result['dayOfYear'],
                          'weekNo':result['weekNo']
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
                            fontWeight: FontWeight.w300,
                            fontSize: 35,
                            letterSpacing: 3.0,
                            color: fontColor,
                          ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text(
                    data['time']!,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 60,
                      letterSpacing: 2.0,
                      color: timeColor,
                    ),
                  ),
                  SizedBox(height: 30,),
                  Center(
                    child: Card(
                        color: Colors.grey.shade800,
                        shadowColor: Colors.white,
                        elevation: 200,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.grey.shade800,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(18))
                        ),
                        child: SizedBox(
                          width: 300,
                          height: 400,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text('DAY OF THE WEEK',style: TextStyle(fontSize: 20,color: Colors.grey.shade300,letterSpacing: 2,fontWeight: FontWeight.w300),),
                                SizedBox(height: 30,),
                                Text(data['dayOfWeek'],style: TextStyle(fontSize: 30,color: Colors.amber,fontWeight: FontWeight.w400),),
                                Text('DAY OF YEAR',style: TextStyle(fontSize: 20,color: Colors.grey.shade300,letterSpacing: 2,fontWeight: FontWeight.w300),),
                                SizedBox(height: 30,),
                                Text('WEEK NUMBER',style: TextStyle(fontSize: 20,color: Colors.grey.shade300,letterSpacing: 2,fontWeight: FontWeight.w300),),
                              ],
                            ),
                          ),
                    )
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
