import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:manfred_karge/ApiHandler/Api_Handler.dart';
import 'package:manfred_karge/FormDetailScreen.dart';
import 'package:manfred_karge/Model/FormsModel.dart';
import 'package:manfred_karge/Utils/color_utils.dart';
import 'package:manfred_karge/uploadPicture.dart';

class Forms extends StatefulWidget {
  @override
  _FormsState createState() => _FormsState();
}

class _FormsState extends State<Forms> {
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
          return connected?  FutureBuilder<FormsModel>(
              future: ApiHandler.getForms(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    padding: EdgeInsets.only(left:10,right:10),
                    itemCount: snapshot.data.data.length,
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FormsDetailScreen(id: snapshot.data.data[index].formId)));
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
                                    child: Text(snapshot.data.data[index].formName,maxLines: 2,softWrap: true,overflow: TextOverflow.ellipsis,)),
                              ],
                            ),
                            Divider(color: Colors.grey)
                          ],
                        ),
                      );
                    },
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
