 
import 'dart:io';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:manfred_karge/ApiHandler/Api_Handler.dart';
import 'package:manfred_karge/Home.dart';
import 'package:manfred_karge/Model/ProfileModel.dart';
import 'package:manfred_karge/Utils/color_utils.dart';
import 'package:manfred_karge/Utils/custom_widget.dart';
import 'package:manfred_karge/sharedpreference/store.dart';
import 'package:manfred_karge/uploadPicture.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String  email, phoneNumber, username, address;
  GlobalKey<FormState> key = new GlobalKey();


  // PickedFile _pickedFile;
  // final ImagePicker imagePicker = ImagePicker();
   ProgressDialog pr;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //  ApiHandler.getProfile();
  // }

  // void takePhoto(ImageSource source) async {
  //   final pickedFile = await imagePicker.getImage(source: source);
  //   setState(() {
  //     _pickedFile = pickedFile;
  //   });
  // }
  _asyncFileUpload() async {
    setState(() {
      pr.show();
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("token");
    print("token" + "$store1");
    var header = "Bearer $store1";
    //create multipart request for POST or PATCH method
    final String url = "https://manfredkarger.ouctus-platform.com/api/user";
    var request = http.MultipartRequest("POST", Uri.parse(url));
    // var request = http.MultipartRequest
    Map<String, String> headers= {
      "Content-Type": "application/json",
      'Authorization': '$header',
    };
    request.headers.addAll(headers);
    request.fields['name'] = username.toString();
    request.fields['phoneNumber'] = phoneNumber.toString();
    request.fields['address'] = address.toString();
    request.fields['phoneNumber'] = phoneNumber.toString();
   // var pic = await http.MultipartFile.fromPath("profileImage", _pickedFile.path);
    //add multipart to request
   // request.files.add(pic);
    print(request);
    var response = await request.send();
    print(response);
    if(response.statusCode == 200 ){
      setState(() {
        pr.hide();
      });
      Fluttertoast.showToast(
          msg: "Updated Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue[200],
          textColor: Colors.black,
          fontSize: 16.0);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    return Scaffold(
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
          return connected? FutureBuilder<ProfileModel>(
            future: ApiHandler.getProfile(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("assets/image/pfofile-back.png"),
                        )),
                        child: Form(
                          key: key,
                          child: Container(
                              height: MediaQuery.of(context).size.height,
                              child: Stack(children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30.0, left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
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
                                      GestureDetector(
                                        onTap: (){
                                          final loginForm = key.currentState;
                                          if (loginForm.validate()) {
                                            loginForm.save();
                                            _asyncFileUpload();
                                          } else {
                                            print("rrrrrrr");
                                          }

                                        },
                                        child: Align(
                                            alignment: Alignment.topRight,
                                            child: Image.asset(
                                              "assets/image/edit.png",
                                              height: 25,
                                              width: 40,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 140,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 15.0, right: 20.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                        ),
                                      ),
                                      height: 490,
                                      width: MediaQuery.of(context).size.width - 30,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 70,
                                  right: 0,
                                  left: 0,
                                  child: Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 15,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border:
                                            Border.all(width: 3.0, color: Colors.white),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          _showSelectionDialog(context);
                                        },
                                        child:CircleAvatar(
                                          radius: 60,
                                          backgroundColor: Colors.white,
                                          // backgroundImage: _pickedFile == null
                                          //     ? snapshot.data.data.profileImage != null ?NetworkImage(
                                          //   ApiHandler.url+snapshot.data.data.profileImage,
                                          // ):AssetImage("assets/images/beispiel-entruempelung.jpg")
                                          //     : FileImage(File(_pickedFile.path)),
                                        ),
                                      )),
                                ),
                                Positioned(
                                  top: 130,
                                  left: 0,
                                  right: 0,
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.only(
                                            top: 80.0,
                                          ),
                                          child:
                                              CustomWidget.getProfileTextField(context,
                                                  text: "Name",
                                                  //hintText: "JhonDeo",
                                                  initialValue: snapshot.data.data.name,
                                                  onSaved: (val) => username = val,
                                                  keyboardType: TextInputType.text)),
                                      CustomWidget.getProfileTextField(context,
                                          text: "Email",
                                          //hintText: "JohnDEo@gmail.com",
                                          initialValue: snapshot.data.data.emailAddress,
                                          onSaved: (val) => email = val,
                                          keyboardType: TextInputType.emailAddress),
                                      CustomWidget.getProfileTextField(context,
                                          text: "Address",
                                          initialValue: snapshot.data.data.address,
                                          onSaved: (val) => address = val,
                                          //hintText: "mcf-150/b adarash nagar",
                                          keyboardType: TextInputType.text),
                                      CustomWidget.getProfileTextField(context,
                                          text: 'Mobile Number',
                                          //hintText: '12333478',
                                          onSaved: (val) => phoneNumber = val,
                                          initialValue: snapshot.data.data.phoneNumber,
                                          keyboardType: TextInputType.text)
                                    ],
                                  ),
                                ),
                              ])),
                        )),
                  ],
                );
              } else {
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

    );
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("From where do you want to choose the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Column(
                      children: [
                        Text(
                          "choose your profile photo",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlatButton.icon(
                              icon: Icon(Icons.camera),
                              label: Text("Camera"),
                              onPressed: () {
                                //takePhoto(ImageSource.camera);
                              },
                            ),
                            FlatButton.icon(
                              icon: Icon(Icons.photo),
                              label: Text("Gallery"),
                              onPressed: () {
                               // takePhoto(ImageSource.gallery);
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ));
        });
  }
}
