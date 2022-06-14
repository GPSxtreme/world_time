// ignore_for_file: camel_case_types, avoid_print

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:world_time/services/world_time.dart';

class allTimeZonesReturner {
  Future<void> returnAllTimeZones(List<worldTime> list,List<String> cities) async {
    try {
      String apiEndPoint = "https://worldtimeapi.org/api/timezone";
      String name;
      String continent;
      String nameSubString;
      Map<dynamic,dynamic> flagList = {};
      Uri url = Uri.parse(apiEndPoint);
      Response response = await get(url);
      List<dynamic> data = jsonDecode(response.body);
      final  jsonData = await rootBundle.loadString('assets/flags.json');
      final dataJson = json.decode(jsonData) as List<dynamic>;
      for(int i=0;i<dataJson.length;i++){
        flagList[dataJson[i]['timezone']] = dataJson[i]['flag'];
      }
      for (int i = 0; i < data.length; i++) {
        late String flagUrl ;
        name = data[i];
        continent = name.substring(0, name.indexOf('/'));
        if (name.contains('/') && !name.contains('Etc')) {
          nameSubString = name.substring(name.indexOf('/') + 1);
          nameSubString = nameSubString.replaceAll('_',' ');
          nameSubString = nameSubString.replaceAll('/', ' ');
          cities.add(nameSubString);
          for (var key in flagList.keys) {
            if(name == key){
              flagUrl = flagList[key];
              break;
            }else{
              flagUrl = 'https://blog.fluidui.com/content/images/2019/01/designernews.png';
            }
          }
          list.add(worldTime(location: nameSubString,
              flag: flagUrl,
              locationUrl: name,
          country: continent));
        }
      }
    }
    catch (e) {
      print(e);
    }
  }
}