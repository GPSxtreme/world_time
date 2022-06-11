// ignore_for_file: camel_case_types

import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class worldTime{

  String location;//location name for the ui
  late String time;//the time in that location
  String flag;//url to an asset logo
  String locationUrl;//location url
  late String dayOfWeek;
  late String dayOfYear;
  late String weekNo;
  late bool isDay;
  //constructor
  worldTime({required this.location,required this.flag,required this.locationUrl});
  //main function
  Future<void> getTime() async{

    try{
      String apiEndPoint = "https://worldtimeapi.org/api/timezone/$locationUrl";
      //all the time zones for referece : https://worldtimeapi.org/timezones
      Uri url = Uri.parse(apiEndPoint);
      Response response = await get(url);
      Map data = jsonDecode(response.body);
      //get properties from data
      String dateTime = data['utc_datetime'];
      String offSetHour = data['utc_offset'].substring(1,3);
      String offSetMin = data['utc_offset'].substring(4,6);
      //set days thing
      dayOfWeek = data['day_of_week'];
      //print(dayOfWeek);
      dayOfYear = data['day_of_year'];
      weekNo = data['week_number'];
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
      //set is day
      isDay = now.hour > 6 && now.hour < 20 ? true:false;
      //set time property
      time = DateFormat.jm().format(now);
    }
    catch(e){
      //print(e);
      time = 'Could not fetch time data';
    }

  }

}