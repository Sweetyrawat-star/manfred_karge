import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manfred_karge/Utils/custom_widget.dart';
import 'package:manfred_karge/oneTimePassword.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  String email, password, otp, userId;
  ProgressDialog pr;
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> otpMethod() async {
    setState(() {
      pr.show();
    });
    var body = ({
      "emailAddress": email.toString(),
    });
    String url = "https://manfredkarger.ouctus-platform.com/api/forgetpassword";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var jsonResponse;
    var response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("response statusCode ${response.statusCode}");
      print("body$jsonResponse");
      if (jsonResponse != null) {
        setState(() {
        });
        sharedPreferences.setString(
            "otp", jsonResponse["data"]["otp"].toString());
        sharedPreferences.setString(
            "userId", jsonResponse["data"]["userId"].toString());
        print("otp " + "${jsonResponse["data"]["otp"].toString()}");
        print("userId" + "${jsonResponse["data"]["userId"].toString()}");
        otp = sharedPreferences.getString("otp");
        print("otp" + "$otp");
        userId = sharedPreferences.getString("userId");
        print("userId" + "$userId");
        /* var id = sharedPreferences.setString("UserId", jsonResponse["data"]["data"]["UserId"].toString());
        print(" id $id");*/
        /* var token2 = sharedPreferences.getString("token");
        print(token2);*/
        Fluttertoast.showToast(
            msg: "LogIn Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue[200],
            textColor: Colors.black,
            fontSize: 16.0);
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNavigationBarPage()));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => OneTimePassword(
                      userId: userId.toString(),
                      otp: otp.toString(),
                    )),
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
      /* else {
        setState(() {
          _isLoading = false;
        });
        print("response body ${response.body}");
      }
    }*/
    }
  }

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
                      height: 30,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          text: "Forgot Password",
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
                      child: CustomWidget.getAppThemeTextFieldIcon(
                        context,
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (val) => email = val,
                        hintText: "Email",
                        validator: (val) {
                          return val.length < 1 ? "Enter your email" : null;
                        },
                        suffixIcon: Image.asset(
                          "assets/image/email.png",
                          height: 5,
                          width: 12,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomWidget.appButton(
                        height: 60,
                        size: 20,
                        width: double.infinity,
                        context: context,
                        text: 'Send',
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => OneTimePassword()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
