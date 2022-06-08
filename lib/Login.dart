import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:manfred_karge/ForgotPassword.dart';
import 'package:manfred_karge/Home.dart';
import 'package:manfred_karge/Register.dart';
import 'package:manfred_karge/Utils/custom_widget.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String email, password;
  ProgressDialog pr;
  bool showPassword = false;
  @override
  void initState() {
    super.initState();
    showPassword = false;
  }
  Future<void> signUp() async {
    setState(() {
      pr.show();
    });
    var body = ({
      "emailAddress": email.toString(),
      "password": password.toString(),
    });

    String url = "https://manfredkarger.ouctus-platform.com/api/login";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonResponse;
    var response = await http.post(url, body: body);
    if (response.statusCode == 422) {
    } else {
      jsonResponse = json.decode(response.body);
      print("response statusCode ${response.statusCode}");
      print("body$jsonResponse");
      print("response body ${jsonResponse["token"]}");
      var status = jsonResponse["status"];
      print(status);
      if (jsonResponse != null &&
          status == "success" &&
          response.statusCode != 422) {
        setState(() {
        });

        sharedPreferences.setString(
            "UserId", jsonResponse["data"]["UserId"].toString());
        sharedPreferences.setString(
            "token", jsonResponse["data"]["token"].toString());
        print("token " + "${jsonResponse["data"]["token"].toString()}");
        print("UserId" + "${jsonResponse["data"]["UserId"].toString()}");
        var id =
            sharedPreferences.setInt("UserId", jsonResponse["data"]["UserId"]);
        print(" id $id");
        var token2 = sharedPreferences.getString("token");
        print(token2);
        Fluttertoast.showToast(
            msg: "User login successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue[200],
            textColor: Colors.black,
            fontSize: 16.0);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
            (Route<dynamic> route) => false);
      } else {
        print("respopnse body---------$body");
        print("Error");
        setState(() {
          pr.hide();
        });
        Fluttertoast.showToast(
            msg: "Something want worng",
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
    }
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Color(0xff081D32)),
            child: ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10, top: 80),
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
                        Padding(
                          padding: EdgeInsets.all(10),
                          child:  CustomWidget.getAppThemeTextFieldIcon(
                            context,
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (val) => email = val,
                                hintText: "Email",
                                validator: (val) {
                                  return val.length < 1
                                      ? "Enter your email"
                                      : null;
                                },
                                  suffixIcon: Image.asset(
                                    "assets/image/email.png",
                                    height: 5,
                                    width: 12,
                                    fit: BoxFit.fitHeight,
                                  ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: CustomWidget.getAppThemeTextField(
                            context,
                                counterText: "",
                                keyboardType: TextInputType.text,
                                onSaved: (val) => password = val,
                                validator: (val) {
                                  return val.length < 8
                                      ? "Enter maximum 8 digit password"
                                      : null;
                                },hintText: "Password",
                                maxLength: 15,
                                maxEnforced: true,

                                isPass: !showPassword,
                            onTap: (){
                              setState(() {
                                showPassword = !showPassword;

                              });
                            },
                                  suffixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                )
                          ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 10.0, top: 10, bottom: 40),
                              child: RichText(
                                text: TextSpan(
                                  text: "Forgot Password?",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: CustomWidget.appButton(
                              height: 60,
                              size: 20,
                              width: double.infinity,
                            context: context,
                            text: 'SIGN IN',
                            onTap: () {
                              final loginForm = _formKey.currentState;
                              if (loginForm.validate()) {
                                loginForm.save();
                                signUp();
                              } else {
                                print("rrrrrrr");
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              text: " Don't have an account?",
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Register()));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(
                                text: "SIGN UP ",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
