// ignore_for_file: camel_case_types, avoid_print

import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:world_time/services/world_time.dart';
class flag {
  Future<String> returnFlag(List<worldTime> list, int index)async{
    late String url;
    final  jsonData = await rootBundle.loadString('assets/flags.json');
    final data = json.decode(jsonData) as Map<dynamic,dynamic>;
    for (int i = 0; i < list.length; i++) {
      if (list[index].locationUrl == data['timezone']) {
        url = data[i]['flag'];
      } else {
        return "https://countryflagsapi.com/png/dz";
      }
    }
    return url;
  }
}