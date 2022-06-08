import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:html/parser.dart';
import 'package:manfred_karge/ApiHandler/Api_Handler.dart';
import 'package:manfred_karge/Model/servicesListModel.dart';
import 'package:manfred_karge/Utils/color_utils.dart';
import 'package:manfred_karge/uploadPicture.dart';

class Services extends StatefulWidget {
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.lightOrangeColor,
        title: Text(
          "Services",
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UploadPicture()));
        },
        child: Icon(
          Icons.insert_drive_file_rounded,
          color: Colors.white,
        ),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return connected
              ? FutureBuilder<GetManFredServices>(
                  future: ApiHandler.getServices(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                          padding:
                              EdgeInsets.only(top: 10, right: 10, left: 10),
                          children: [
                            Text(
                              "Services - moving near and far",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: ColorUtils.lightOrangeColor,
                                  fontFamily: "Pacifico"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              " We carry out all removals within the agreed time frame and with qualified staff. You can rely on us!"
                              " Our services include:",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.data.length,
                              itemBuilder: (context, index) {
                                var document = parse(snapshot
                                    .data.data[index].serviceDescription);
                                return Container(
                                    padding: EdgeInsets.only(top: 20),
                                    child: GestureDetector(
                                        onTap: () {},
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 100,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://manfredkarger.ouctus-platform.com/" +
                                                          snapshot
                                                              .data
                                                              .data[index]
                                                              .serviceIcon),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 330,
                                                    child: Text(
                                                      snapshot.data.data[index]
                                                          .serviceName,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                           textAlign: TextAlign.justify,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: ColorUtils
                                                              .lightOrangeColor),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    document.body.text,
                                                     textAlign: TextAlign.justify,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        )));
                              },
                            )
                          ]);
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              : Center(
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
