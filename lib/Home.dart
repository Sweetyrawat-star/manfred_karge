
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:manfred_karge/ApiHandler/Api_Handler.dart';
import 'package:manfred_karge/ClearingOut.dart';
import 'package:manfred_karge/CompanyMoves.dart';
import 'package:manfred_karge/Model/DashboardModel.dart';
import 'package:manfred_karge/Utils/color_utils.dart';
import 'package:manfred_karge/drawerutils.dart';
import 'package:manfred_karge/privateRemoval.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex;
  var servicesId;
  @override
  void initState() {
    super.initState();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: ColorUtils.lightOrangeColor,
        
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10),
            child: Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                    onTap: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                    child: Image.asset(
                      "assets/image/menu1.png",
                      height: 35,
                      width: 40,
                    ))),
          ),
        ),
        drawer: Container(
          width: 220.0,
          child: Drawer(
            child: DrawerUtil(),
          ),
        ),
        backgroundColor: Color(0xffF4F4F4),
        body: OfflineBuilder(
          connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
              ) {
            final bool connected = connectivity != ConnectivityResult.none;
            return connected?  FutureBuilder<DashboardModel>(
              future: ApiHandler.getProductDetails(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("assets/image/home-back.png"),
                      )),
                      child: ListView(
                        children: <Widget>[
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  ApiHandler.url+snapshot.data.data.banners.bannerImage,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.data.services.length,
                            itemBuilder: (BuildContext context, int index) {
                              servicesId = snapshot.data.data.services[index].serviceId;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (index == 0){
                                      setState(() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => PrivateRemoval(id: snapshot.data.data.services[index].serviceId,)));
                                      });
                                    } else if (index == 1) {
                                      setState(() {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => CompanyMoves(id: snapshot.data.data.services[index].serviceId,)));
                                      });
                                    } else {
                                      setState(() {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => ClearingOut(id: snapshot.data.data.services[index].serviceId,)));
                                      });
                                    }
                                    selectedIndex = index;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15),
                                  child: Card(
                                    elevation: 3,
                                    child: Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: selectedIndex == index
                                            ? ColorUtils.appColor
                                            : ColorUtils.appColor,
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      padding: const EdgeInsets.only(left: 10.0, right: 15.0),
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    ApiHandler.url+snapshot.data.data.services[index].serviceIcon,
                                                  ),
                                                  fit: BoxFit.fitHeight),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 1.0,
                                          ),
                                          Container(
                                            height: 50,
                                            width: 1,
                                            decoration: BoxDecoration(
                                              color: ColorUtils.lightOrangeColor,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 30.0,
                                          ),
                                          Container(
                                            width: 180,
                                            child: Text(snapshot.data.data.services[index].serviceName,
                                                //"Self Pick Up",
                                                style: TextStyle(
                                                    color: selectedIndex == index
                                                        ? Colors.white
                                                        : Colors.white,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w600)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ));
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
