// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  late String bgImg;
  late Color bgColor;
  late Color fontColor;
  late Color timeColor;
  late Color cardColor;
  late Color cardHeadColor;
  late Color cardTextColor;
  late double divThicc;
  late Color timeCard;
  late Color fotterColor;
  late Color fotterTextColor;
  //my profile
  final Uri url = Uri.parse("https://github.com/GPSxtreme");
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty? data: ModalRoute.of(context)?.settings.arguments as Map;
    if(data['isDay']!=null){
      bgImg = data['isDay'] ? 'day2.png':'night2.png'; //setting background image
      bgColor = data['isDay'] ? Colors.transparent : Colors.grey.shade900;//setting background colour
      fontColor = data['isDay'] ? Colors.grey.shade100:Colors.white;//setting font color
      timeColor = data['isDay'] ? Colors.grey.shade100:Colors.black;//setting font color
      cardColor = data['isDay'] ? Colors.grey.shade100:Colors.black;//setting font color
      cardTextColor = data['isDay'] ? Colors.grey.shade900:Colors.grey.shade300;//setting font color
      fotterTextColor = data['isDay'] ? Colors.grey.shade100:Colors.blueAccent;//setting font color
      fotterColor = Colors.black;//setting bgColor
      cardHeadColor =  Colors.blueAccent;//setting font color
      timeCard = data['isDay'] ? Colors.black:Colors.white;//setting font color
      divThicc = data['isDay'] ? 0.5:0.1;
    }

    return Scaffold(
      backgroundColor:bgColor,
      // bottomNavigationBar: BottomAppBar(
      //   color: fotterColor,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: <Widget>[
      //       Row(
      //         children: <Widget>[
      //           Text('Made by'.toUpperCase(),style: TextStyle(fontWeight: FontWeight.w800,letterSpacing: 2,color: fotterTextColor),),
      //           TextButton(
      //             onPressed: _launchUrl,
      //             child: Text('GPSxtreme',style: TextStyle(fontWeight: FontWeight.w800,letterSpacing: 1.2,color: fotterTextColor,fontSize: 16)),
      //           )
      //         ],
      //       ),
      //       SizedBox(height: 40,),
      //     ],
      //   ),
      // ),
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/$bgImg'),fit: BoxFit.cover ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextButton.icon(onPressed: ()async {
                          dynamic result = await Navigator.pushNamed(
                          context, '/location');
                          if (result != null) {
                          setState(() {
                          data = {
                            'time': result['time'],
                            'location': result['location'],
                            'isDay': result['isDay'],
                            'flag': result['flag'],
                            'dayOfWeek': result['dayOfWeek'],
                            'dayOfYear': result['dayOfYear'],
                            'weekNo': result['weekNo']
                             };
                            });
                            }
                          },
                          icon:  Icon(Icons.edit,color:fontColor,size: 20), label: Text(data['location']!.toUpperCase(), style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, letterSpacing: 3.0, color: fontColor,),),
                        ),
                        DottedLine(
                          direction: Axis.horizontal,
                          lineLength: 250,
                          lineThickness: 0.5,
                          dashLength: 4.0,
                          dashRadius: 2.0,
                          dashGapLength: 6.0,
                          dashGapColor: Colors.transparent,
                          dashColor: fontColor,
                          dashGapRadius: 8.0,
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    Card(
                      color: timeCard,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.grey.shade800,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(18))
                      ),
                      child: SizedBox(
                        height: 100,
                        width: 300,
                        child:  Center(
                          child: Text(
                            data['time']!,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 60,
                              letterSpacing: 2.0,
                              color: timeColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Center(
                      child: Card(
                          color: cardColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18))
                          ),
                          child: SizedBox(
                            width: 300,
                            height: 400,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0, 51.5, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text('DAY OF THE WEEK',style: TextStyle(fontSize: 18,color: cardHeadColor,letterSpacing: 2,fontWeight: FontWeight.w500),),
                                  SizedBox(height: 15,),
                                  Text(data['dayOfWeek'].toString(),style: TextStyle(fontSize: 30,color: cardTextColor,fontWeight: FontWeight.w700,letterSpacing: 2),),
                                  SizedBox(height: 20,),
                                  Divider(height: 0, thickness: divThicc, color: Colors.grey[300],indent: 50,endIndent: 50,),
                                  SizedBox(height: 20,),
                                  Text('DAY OF YEAR',style: TextStyle(fontSize: 18,color: cardHeadColor,letterSpacing: 2,fontWeight: FontWeight.w500),),
                                  SizedBox(height: 15,),
                                  Text(data['dayOfYear'].toString(),style: TextStyle(fontSize: 35,color: cardTextColor,fontWeight: FontWeight.w700,letterSpacing: 1.5),),
                                  SizedBox(height: 20,),
                                  Divider(height: 0, thickness: divThicc, color: Colors.grey[300],indent: 50,endIndent: 50,),
                                  SizedBox(height: 20,),
                                  Text('WEEK NUMBER',style: TextStyle(fontSize: 18,color: cardHeadColor,letterSpacing: 2,fontWeight: FontWeight.w500),),
                                  SizedBox(height: 15,),
                                  Text(data['weekNo'].toString(),style: TextStyle(fontSize: 35,color: cardTextColor,fontWeight: FontWeight.w700,letterSpacing: 1.5),),
                                ],
                              ),
                            ),
                      )
                      ),
                    ),
                    Card(
                      color: fotterColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(18),bottomRight: Radius.circular(5),topLeft: Radius.circular(5),topRight: Radius.circular(18))
                      ),
                      child: SizedBox(
                        height: 60,
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('Made by'.toUpperCase(),style: TextStyle(fontWeight: FontWeight.w800,letterSpacing: 2,color: fotterTextColor),),
                                TextButton(
                                  onPressed: _launchUrl,
                                  child: Text('GPSxtreme',style: TextStyle(fontWeight: FontWeight.w800,letterSpacing: 1.2,color: fotterTextColor,fontSize: 16)),
                                )
                              ],
                            ),
                            SizedBox(height: 40,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
  //methods
  void _launchUrl() async {
    await launchUrl(url);
  }
}

