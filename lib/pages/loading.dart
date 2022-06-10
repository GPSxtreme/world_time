// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void getTime() async{
    String apiEndPoint = "https://worldtimeapi.org/api/timezone/Asia/Kolkata";
    //all the time zones for referece : https://worldtimeapi.org/timezones
    Uri url = Uri.parse(apiEndPoint);
    Response response = await get(url);
    Map data = jsonDecode(response.body);
    print(data['datetime']);
    //get properties from data
    String dateTime = data['utc_datetime'];
    String offSetHour = data['utc_offset'].substring(1,3);
    String offSetMin = data['utc_offset'].substring(4,6);
    //check if off set is negative
    String offSetType = data['utc_offset'][0];
    //create datetime obj
    DateTime now = DateTime.parse(dateTime);
    if(int.parse(offSetHour)>0 && offSetType == '+') {
      now = now.add(Duration(minutes: int.parse(offSetMin),hours: int.parse(offSetHour)));
    }
    if(int.parse(offSetHour)>0 && offSetType == '-') {
      now = now.subtract(Duration(minutes: int.parse(offSetMin),hours: int.parse(offSetHour)));
    }
    print(now);
  }

  @override
  void initState(){
    super.initState();
    getTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: Text('loading screen'),
    );
  }
}
