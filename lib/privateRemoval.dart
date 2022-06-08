import 'dart:convert';
import 'dart:io';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:flutter/material.dart';
import 'package:manfred_karge/Model/ServicesModel.dart';
import 'package:manfred_karge/Utils/color_utils.dart';
import 'package:manfred_karge/uploadPicture.dart';

class PrivateRemoval extends StatefulWidget {
  final int id;
  PrivateRemoval({
    this.id,
  });
  @override
  _PrivateRemovalState createState() => _PrivateRemovalState();
}

class _PrivateRemovalState extends State<PrivateRemoval> {
  Future<ServicesModel> getServices() async {
    try {
      final url =
          "https://manfredkarger.ouctus-platform.com/api/service/details/${widget.id}";
      final response = await http.get(
        url,
      );
      print(response);
      if (response.statusCode == 200) {
        var aboutUs = jsonDecode(response.body);
        print(response.statusCode);
        print(response.body);
        return ServicesModel.fromJson(aboutUs);
      } else {
        throw Exception();
      }
    }on SocketException {
      print('No Internet connection 😑');
    } on HttpException {
      print("Couldn't find the post 😱");
    } on FormatException {
      print("Bad response format 👎");
    } catch (e) {
      print(e);
    }
    return ServicesModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorUtils.lightOrangeColor,
          title: Text(
            "Private Removals",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10),
            child: GestureDetector(
              onTap: () {
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
        backgroundColor: Color(0xffF4F4F4),
      body:OfflineBuilder(
        connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
            ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return connected?  FutureBuilder<ServicesModel>(
              future: getServices(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var document = parse(snapshot.data.data.serviceDescription);
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/image/beispiel-privatumzug-karger.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:10,right:10, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                              document.body.text,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ):Center(
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
    );
  }
}
