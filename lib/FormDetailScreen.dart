import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:manfred_karge/Model/FormDetailScreenModel.dart';
import 'package:manfred_karge/PdfViewer.dart';
import 'package:manfred_karge/Utils/color_utils.dart';
import 'package:manfred_karge/uploadPicture.dart';


class FormsDetailScreen extends StatefulWidget {
  final int id;
  FormsDetailScreen (
      {this.id,});
  @override
  _FormsDetailScreenState createState() => _FormsDetailScreenState();
}

class _FormsDetailScreenState extends State<FormsDetailScreen> {
  String url;


  Future<FormDetailScreenModel> formDetailScreenModel() async {
    try{
      final url = "https://manfredkarger.ouctus-platform.com/api/form/detail/${widget.id}";
      final response = await http.get(
        url,
      );
      print(response);
      if (response.statusCode == 200) {
        var aboutUs = jsonDecode(response.body);
        print(response.statusCode);
        print(response.body);
        return FormDetailScreenModel.fromJson(aboutUs);
      } else {
        throw Exception();
      }
    }on SocketException {
      print('No Internet connection 😑');
    } on HttpException {
      print("Couldn't find the post 😱");
    } on FormatException {
      print("Bad response format 👎");
    }
    catch(e){
      print(e);
    }
    return FormDetailScreenModel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.lightOrangeColor,
        title: Text("Forms",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        leading:  Padding(
          padding: const EdgeInsets.only(top:10.0,left: 10),
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
      backgroundColor: Color(0xffF4F4F4),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorUtils.lightOrangeColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> UploadPicture()));
        },
        child: Icon(
          Icons.insert_drive_file_rounded,color: Colors.white,
        ),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
            ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return connected?  FutureBuilder<FormDetailScreenModel>(
            future: formDetailScreenModel(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                url = snapshot.data.data.pdfLink;
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PdfViewerPage(url: url,urlName: snapshot.data.data.formName,)));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top:10.0,),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Image.asset("assets/image/download-(1).png",height: 35,width: 40,)),
                              ),
                              SizedBox(
                                  width: 300,
                                  child: Text(snapshot.data.data.formName,maxLines: 2,softWrap: true,overflow: TextOverflow.ellipsis,)),
                            ],
                          ),
                          Divider(color: Colors.grey)
                        ],
                      ),
                    );
              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )  :Center(
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
