import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:manfred_karge/ApiHandler/Api_Handler.dart';
import 'package:manfred_karge/Model/PartnerModel.dart';
import 'package:manfred_karge/Utils/color_utils.dart';
import 'package:manfred_karge/uploadPicture.dart';
import 'package:manfred_karge/webview.dart';


class Partner extends StatefulWidget {
  @override
  _PartnerState createState() => _PartnerState();
}

class _PartnerState extends State<Partner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.lightOrangeColor,
        title: Text("Partners",style: TextStyle(color: Colors.white),),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorUtils.lightOrangeColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> UploadPicture()));
        },
        child: Icon(
          Icons.insert_drive_file_rounded,color: Colors.white,
        ),

      ),
      body:   OfflineBuilder(
        connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
            ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return connected?        FutureBuilder<PartnersModel>(
              future: ApiHandler.getPartner(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return ListView(
                    padding: EdgeInsets.only(top: 10,right: 10,left: 10),
                        children: [
                    Text(
                          "Our partners",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: ColorUtils.lightOrangeColor,
                              fontFamily: "Pacifico"),
                        ),
                        SizedBox(height: 10,),
                        Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                  text:
                                  "As a responsible family company, mutual, professional partnerships with local"
                                      " companies and supraregional partners are very important to us. If you are interested in a "
                                      "long-term cooperation, please contact us."
                              )
                            ],
                          ),
                        ),
                          Container(
                              padding: EdgeInsets.only( top: 20),
                              child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data.data.length,
                                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 20.0,
                                    childAspectRatio: 1.1
                                ),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => WebsitePage(webUrl: snapshot.data.data[index].url)));
                                      },
                                      child: new GridTile(
                                          child: Container(
                                            height: 310,
                                            width: 200,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey),
                                              borderRadius: BorderRadius.circular(5.0),),

                                            child: Padding(
                                              padding: const EdgeInsets.only(left:10,top: 20),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    child: Image.network(ApiHandler.url +
                                                        snapshot.data.data[index]
                                                            .image,
                                                      height: 50,
                                                      width: 150,
                                                    ),
                                                  ),
                                                  SizedBox(height: 20,),
                                                  SizedBox(
                                                    width: 130,
                                                    child: Text(snapshot.data.data[index].name,
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.add_photo_alternate_outlined,size: 12,color: ColorUtils.lightOrangeColor,),
                                                      SizedBox(width: 5,),
                                                      SizedBox(
                                                        width: 120,
                                                        child: Text(snapshot.data.data[index].url,
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          color: ColorUtils.lightOrangeColor,
                                                        ),),
                                                      ),

                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )));
                                },
                              ))

                        ],
                      );
                }else{
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
