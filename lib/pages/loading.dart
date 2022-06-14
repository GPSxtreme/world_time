// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time/services/allTimezones.dart';
import 'package:world_time/pages/choose_location.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupWorldTime() async{
    worldTime instance = worldTime(country: 'India',  location: 'Kolkata', flag: 'https://countryflagsapi.com/png/india', locationUrl: 'Asia/Kolkata');
    await instance.getTime();
    await allTimeZonesReturner().returnAllTimeZones(listOfAllLocations,searchTerms);
    Navigator.pushReplacementNamed(context, '/home',arguments: {'location': instance.location,'flag': instance.flag,'time':instance.time,'isDay':instance.isDay,'dayOfWeek':instance.dayOfWeek,'dayOfYear':instance.dayOfYear,'weekNo':instance.weekNo});
  }

  @override
  void initState(){
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: SpinKitCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
