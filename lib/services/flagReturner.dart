// ignore_for_file: camel_case_types, avoid_print

import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:world_time/services/world_time.dart';
class flag{
  Future<String?> returnFlag (List<worldTime> list,int index)async{
    dynamic response = await rootBundle.loadString('flags.json');
    var data = json.decode(await response);
    for(int i=0;i<list.length;i++){
      if(list[index].locationUrl == data['timezone']){
        return data[i]['flag'];
      }else{
        return 'notFound';
      }
    }
  }
}