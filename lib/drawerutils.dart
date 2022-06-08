
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manfred_karge/AboutUs.dart';
import 'package:manfred_karge/ApiHandler/Api_Handler.dart';
import 'package:manfred_karge/ContactUs.dart';
import 'package:manfred_karge/Forms.dart';
import 'package:manfred_karge/Home.dart';
import 'package:manfred_karge/ImprintsScreen.dart';
import 'package:manfred_karge/Model/ProfileModel.dart';
import 'package:manfred_karge/Partner.dart';
import 'package:manfred_karge/Profile.dart';
import 'package:manfred_karge/ResetPassword.dart';
import 'package:manfred_karge/TermsAndCondition.dart';
import 'package:manfred_karge/UploadDocument.dart';
import 'package:manfred_karge/Utils/color_utils.dart';
import 'package:manfred_karge/sharedpreference/store.dart';
import 'package:manfred_karge/uploadPicture.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Services.dart';


class DrawerUtil extends StatefulWidget {
  @override
  _DrawerUtilState createState() => _DrawerUtilState();
}

class _DrawerUtilState extends State<DrawerUtil> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFunction();
    ApiHandler.getProfile();
  }
  Future<dynamic> getFunction() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getInt("UserId");
    print("user id-----------------------------------------------------------------------" +"$store1");
    return store1;
  }



  drawerHeader(){
    return store1 !=null ?Container(
      height: 110.0,
      decoration: BoxDecoration(
        color: ColorUtils.appColor,
          border: Border(
              bottom: BorderSide(
                  color: Colors.grey[300],
                  width: 0.5
              )
          )
      ),
      child: FutureBuilder<ProfileModel >(
        future: ApiHandler.getProfile(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right:10.0,),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.close,color: Colors.white,size: 28,
                      ),
                    ),
                  ),
                ),
                Align(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      backgroundImage: snapshot.data.data.profileImage != null?
                      AssetImage("assets/image/Contemporary-Living-Room-Easy-Functionality.jpg"):AssetImage("assets/image/Contemporary-Living-Room-Easy-Functionality.jpg"),
                    ),
                    title: Text(snapshot.data.data.name,style: TextStyle(color: Colors.white),),
                    subtitle: Text(snapshot.data.data.emailAddress,style: TextStyle(color: Colors.grey),),

                  ),
                ),
              ],
            );
          }else{
            return Container(
              height: 110.0,
              decoration: BoxDecoration(
                  color: ColorUtils.appColor,
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.grey[300],
                          width: 0.5
                      )
                  )
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right:10.0,),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Icon(Icons.close,color: Colors.white,size: 28,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage("assets/image/Contemporary-Living-Room-Easy-Functionality.jpg"),
                      ),
                      title: Text("Manfred Karger",style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    ):Container(
      height: 110.0,
      decoration: BoxDecoration(
          color: ColorUtils.appColor,
          border: Border(
              bottom: BorderSide(
                  color: Colors.grey[300],
                  width: 0.5
              )
          )
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right:10.0,),
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Icon(Icons.close,color: Colors.white,size: 28,
                ),
              ),
            ),
          ),
          Align(
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage("assets/image/Contemporary-Living-Room-Easy-Functionality.jpg"),
              ),
              title: Text("Manfred Karger",style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
        statusBarColor: ColorUtils.appColor),
      child: Scaffold(
       body: ListView(
          children: <Widget>[
            drawerHeader(),
            SizedBox(height:4),
            _buildDrawerItems(text: 'Home',onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));}),
            _buildDrawerItems(text: 'Services',onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> Services()));}),
            _buildDrawerItems(text: 'Forms',onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> Forms()));}),
            _buildDrawerItems(text: 'Upload Documents',onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> UploadDocument()));}),
               store1 == null?Container() :_buildDrawerItems(text: 'Profile',onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));}),
            _buildDrawerItems(text: 'Upload Image',onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> UploadPicture()));}),
            _buildDrawerItems(text: 'Contact Us',onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> ContactUs()));}),
            _buildDrawerItems(text: 'About Us',onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutUs()));}),
            _buildDrawerItems(text: 'Partner',onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>  Partner()));}),
            _buildDrawerItems(text: 'Imprints',onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> ImprintScreen()));}),
          //  _buildDrawerItems(text: 'Privacy',onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));}),
            _buildDrawerItems(text: 'Terms And Conditions',onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> TermsAndCondition()));}),
           store1 == null?Container() :_buildDrawerItems(text: 'Reset Password',onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> ResetPassword()));}),
            store1 == null?Container() : _buildDrawerItems(text: 'Logout',onTap: (){
              setState(() {
                showAlertDialog( ctxt: context);
              });
            }),

          ],
        ),

      ),
    );
  }


  _buildDrawerItems({ String text, GestureTapCallback onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: EdgeInsets.only(left: 15.0,top:6 ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(text,style: TextStyle(color: Colors.black87,
            ),),SizedBox(height: 6,),Divider()
          ],
        ),
      ),
    );
  }
  showAlertDialog({BuildContext ctxt}) {
    Future<void> onLogoutClicked() async {
       SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      store1 = sharedPreferences.getString("token");
      //print("token" + "$store1");
      String url = "https://manfredkarger.ouctus-platform.com/api/logout";
      var jsonResponse;
      var header = "Bearer $store1";
      var response = await http.post(url, headers: {
        "Content-Type": "application/json",
        'Authorization': '$header',
      });
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        print("response statusCode ${response.statusCode}");
        print("body$jsonResponse");
        if (jsonResponse != null) {
          var token2 = sharedPreferences.getString("token");
          print(token2);
          sharedPreferences.clear();
          Fluttertoast.showToast(
              msg: "LogOut Successful",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue[200],
              textColor: Colors.black,
              fontSize: 16.0);
          Navigator.of(ctxt).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => HomeScreen()),
                  (Route<dynamic> route) => false);
        } else {
          print("Error");
          Fluttertoast.showToast(
              msg: "Something went wrong",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 20,
              backgroundColor: Colors.blue[200],
              textColor: Colors.black,
              fontSize: 16.0);

        }
      }
    }
  Widget cancelButton = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      onPressed: () {
        Navigator.pop(ctxt);
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        "Logout",
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        onLogoutClicked();

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Log Out App!"),
      content: Text(
        "Do you want to Log Out from the app?",
        style: TextStyle(color: Colors.grey),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: ctxt,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
