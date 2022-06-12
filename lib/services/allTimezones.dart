// ignore_for_file: camel_case_types, avoid_print

import 'dart:async';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:world_time/services/world_time.dart';

class allTimeZonesReturner {
  Future<void> returnAllTimeZones(List<worldTime> list) async {
    try {
      String apiEndPoint = "https://worldtimeapi.org/api/timezone";
      String name;
      String country;
      String nameSubString;
      Uri url = Uri.parse(apiEndPoint);
      Response response = await get(url);
      List<dynamic> data = jsonDecode(response.body);
      for (int i = 0; i < data.length; i++) {
        name = data[i];
        country = name.substring(0, name.indexOf('/'));
        if (name.contains('/') && !name.contains('Etc')) {
          nameSubString = name.substring(name.indexOf('/') + 1);
          nameSubString = nameSubString.replaceAll('_',' ');
          nameSubString = nameSubString.replaceAll('/', ' ');
          list.add(worldTime(location: nameSubString,
              flag: '$nameSubString.png',
              locationUrl: name,
          country: country));
          print(country);
        }
      }
    }
    catch (e) {
      print(e);
    }
  }
}