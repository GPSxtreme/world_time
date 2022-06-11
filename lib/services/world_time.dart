import 'package:http/http.dart';
import 'dart:convert';

class worldTime{

  String location;//location name for the ui
  late String time;//the time in that location
  String flag;//url to an asset logo
  String locationUrl;//location url
  //constructor
  worldTime({required this.location,required this.flag,required this.locationUrl,});
  //main function
  Future<void>  getTime() async{
    String apiEndPoint = "https://worldtimeapi.org/api/timezone/$locationUrl";
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
    //set time property
    time = now.toString();
  }

}