// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:world_time/services/allTimezones.dart';
import 'package:world_time/services/world_time.dart';
import 'package:world_time/services/flagReturner.dart';

List<worldTime> listOfAllLocations = [];
class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);
  
  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  Future<void> updateTime(index) async{
    worldTime instance = listOfAllLocations[index];
    print(flag().returnFlag(listOfAllLocations,index).toString());
    await instance.getTime();
    //navigate to home screen
    Navigator.pop(context,{'location': instance.location,'flag': instance.flag,'time':instance.time,'isDay':instance.isDay,'dayOfWeek':instance.dayOfWeek,'dayOfYear':instance.dayOfYear,'weekNo':instance.weekNo});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: Text('Choose Location',style: TextStyle(color: Colors.grey.shade100),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey.shade900,
      ),
      body: ListView.builder(
          itemCount: listOfAllLocations.length,
          itemBuilder: (context,index){
            return Card(
              color: Colors.grey.shade200,
              child: ListTile(
                onTap: (){
                  updateTime(index);
                },
                title: Text(listOfAllLocations[index].location,style: TextStyle(color: Colors.grey.shade900,letterSpacing: 1.5,fontWeight: FontWeight.w300),),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage((flag().returnFlag(listOfAllLocations,index).toString()),),
              ),
            )
            );
          },
      ),
    );
  }
}
