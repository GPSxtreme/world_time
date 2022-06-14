// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

List<worldTime> listOfAllLocations = [];
List<String> searchTerms = [];
class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);
  
  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  Future<void> updateTime(index) async{
    worldTime instance = listOfAllLocations[index];
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
        //centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: const Icon(Icons.search),
          )
        ],
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
              //   leading: CircleAvatar(
              //     backgroundImage: AssetImage('assets/logo.png'),
              // ),
            )
            );
          },
      ),
    );
  }
}
//search method

class CustomSearchDelegate extends SearchDelegate {
// first overwrite to
// clear the search text

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }
// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }
// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var location in searchTerms) {
      if (location.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(location);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var location in searchTerms) {
      if (location.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(location);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,

      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
            title: Text(result),
            onTap: () async{
            late int index;
            for(int i = 0; i < listOfAllLocations.length;i++){
            if(listOfAllLocations[i].location == result){
                 index = i;
              }
            }
            worldTime instance = listOfAllLocations[index];
            await instance.getTime();
            //navigate to home screen
            Navigator.pushReplacementNamed(context, '/home',arguments: {'location': instance.location,'flag': instance.flag,'time':instance.time,'isDay':instance.isDay,'dayOfWeek':instance.dayOfWeek,'dayOfYear':instance.dayOfYear,'weekNo':instance.weekNo});
          }
        );
      },
    );
  }
}
