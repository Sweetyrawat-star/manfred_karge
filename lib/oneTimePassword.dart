import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manfred_karge/ResetPassword.dart';
import 'package:manfred_karge/Utils/color_utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OneTimePassword extends StatefulWidget {
  String otp,userId;
  OneTimePassword({this.otp,this.userId});
  @override
  _OneTimePasswordState createState() => _OneTimePasswordState();
}

class _OneTimePasswordState extends State<OneTimePassword> {
  final _formKey = GlobalKey<FormState>();
  ProgressDialog pr;
  Future<void> temparoryPassword() async {
    setState(() {
      pr.show();
    });
    var body = ({
      "temporaryPassword": widget.otp,
      "userId": widget.userId,
      // "password": password.toString(),
    });
    String url = "http://skytacos.ouctus-platform.com/skystacos/v1/verify_temp";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var otp = sharedPreferences.getString("otp");
    print("otp" + "$otp");
    var userId = sharedPreferences.getString("userId");
    print("userId" + "$userId");
    var jsonResponse;
    var response = await http.post(
      url, body: body,/*headers: {
          "cookie": "otp =$password",
    }*/);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("response statusCode ${response.statusCode}");
      print("body$jsonResponse");
      if (jsonResponse != null) {
        setState(() {
        });
        Fluttertoast.showToast(
            msg: "Temporary password Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue[200],
            textColor: Colors.black,
            fontSize: 16.0);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => ResetPassword(userId: widget.userId,)),
                (Route<dynamic> route) => false);
      } else {
        print("respopnse body---------$body");
        print("Error");
        setState(() {
          pr.hide();
        });
        Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 20,
            backgroundColor: Colors.blue[200],
            textColor: Colors.black,
            fontSize: 16.0);
        setState(() {
          pr.hide();
        });
      }

    }}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Color(0xff081D32)),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Image.asset(
                          "assets/image/Manfred Karger-01white.png"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          text: "One-time password",
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: new EdgeInsets.fromLTRB(
                                  10.0, 10.0, 30.0, 30.0),
                              fillColor: Color(0xff284E74),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff284E74)),
                                borderRadius: BorderRadius.circular(5.0),),
                          labelText: 'One-time password',
                          labelStyle: TextStyle(
                              color: Colors.white, fontSize: 20),
                          suffixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                            size: 25,
                          ),
                        ))
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          child: RaisedButton(
                            color: ColorUtils.lightOrangeColor,
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => ResetPassword()));
                            },
                            child: Text(
                              'Sign Up',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                side: BorderSide(
                                    color: ColorUtils.lightOrangeColor)),
                          ),
                        )),
                  ],
                ),
              ),
            )));
  }
}
