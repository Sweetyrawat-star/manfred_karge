import 'package:flutter_offline/flutter_offline.dart';
import 'package:html/parser.dart' show parse;
import 'package:flutter/material.dart';
import 'package:manfred_karge/ApiHandler/Api_Handler.dart';
import 'package:manfred_karge/Model/AboutUs.dart';
import 'package:manfred_karge/Utils/color_utils.dart';
import 'package:manfred_karge/uploadPicture.dart';
class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.lightOrangeColor,
        title: Text(
          "About Us",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 10),
          child: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  "assets/image/back1.png",
                  height: 35,
                  width: 40,
                )),
          ),
        ),
      ),
       floatingActionButton: FloatingActionButton(
         backgroundColor: ColorUtils.lightOrangeColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> UploadPicture()));
    },
    child: Icon(
    Icons.insert_drive_file_rounded,color: Colors.white,
    ),

    ),
      body: ListView(
        padding: EdgeInsets.only(left:10,right: 10,top: 10),
        children: [
          OfflineBuilder(
            connectivityBuilder: (
                BuildContext context,
                ConnectivityResult connectivity,
                Widget child,
                ) {
              final bool connected = connectivity != ConnectivityResult.none;
              return connected?   FutureBuilder<AboutUsModelPage>(
                future: ApiHandler.getAboutUs(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    var document = parse( snapshot.data.data.aboutUsContent);
                         return Column(
                          children: [
                          Text(
                              document.body.text,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                        ]);
                  }else{
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ) :Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      'There are no bottons to push :)',
                    ),
                    new Text(
                      'Just turn off your internet.',
                    ),
                  ],
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  'There are no bottons to push :)',
                ),
                new Text(
                  'Just turn off your internet.',
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
