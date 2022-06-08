import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manfred_karge/Login.dart';
import 'package:http/http.dart' as http;
import 'package:manfred_karge/Utils/color_utils.dart';
import 'package:manfred_karge/Utils/custom_widget.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;
  bool _isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String confirmPassword, email, phoneNumber, username, password, age;
  bool isDataLoaded = false;
  ProgressDialog pr;
  Future<void> signIn() async {
    setState(() {
      pr.show();
    });
    var body = {"confirmPassword": confirmPassword.toString(),
      "name": username.toString(),
      "emailAddress": email.toString(),
      "phoneNumber": phoneNumber.toString(),
      "password": password.toString(),};
    String url = "https://manfredkarger.ouctus-platform.com/api/register";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonResponse;
    var response = await http.post(url, body: body);
    if (response.statusCode==422) {

    } else {
      jsonResponse = json.decode(response.body);
      print("response statusCode ${response.statusCode}");
      print("body$jsonResponse");
     // print("response body ${jsonResponse["token"]}");
      var status = jsonResponse["status"];
      print(status);
      var msg = jsonResponse["message"];
      print(msg);
      if (jsonResponse != null&& status == 1 && response.statusCode !=422) {
        setState(() {
          _isLoading = false;
        });

        var token1 = sharedPreferences.setString(
            "token", jsonResponse["token"].toString());

        print(token1);
        var token2 = sharedPreferences.getString("token");
        print(token2);
        Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue[200],
            textColor: Colors.black,
            fontSize: 16.0);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => LoginPage()),
                (Route<dynamic> route) => false);
      }
      else {
        print("respopnse body---------$body");
        print("Error");
        setState(() {
          pr.hide();
        });
        Fluttertoast.showToast(
            msg: msg,
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
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Color(0xff081D32)),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Image.asset(
                              "assets/image/Manfred Karger-01white.png"),
                        ),
                        Padding(
                            padding: EdgeInsets.all(10),
                          child: CustomWidget.getAppThemeTextField(
                            context,
                            keyboardType: TextInputType.emailAddress,
                            hintText: "Name",
                                onSaved: (val) => username = val,
                                validator: (val) {
                                  return val.length < 1 ? " Name is required" : null;
                                },
                              suffixIcon: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 25,
                              ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: CustomWidget.getAppThemeTextFieldIcon(
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
                            child: CustomWidget.getAppThemeTextFieldIcon(
                              context,
                              keyboardType: TextInputType.number,
                                  maxLength: 10,
                                  maxEnforced: true,
                                  counterText: "",
                                  onSaved: (val) => phoneNumber = val,
                                  validator: (val) {
                                    return val.length < 10 ? "Enter 10 digit number" : null;
                                  },
                              hintText: " Phone Number",
                              suffixIcon: Image.asset(
                                      "assets/image/phone.png",
                                      fit: BoxFit.fitHeight,
                                    height: 10,
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
                              isPass: true,
                              maxEnforced: true,
                              suffixIcon: Icon(
                                Icons.lock,
                                color: Colors.white,
                                size: 25,
                              ),
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: CustomWidget.getAppThemeTextField(
                              context,
                              counterText: "",
                              keyboardType: TextInputType.text,
                              onSaved: (val) => confirmPassword = val,
                              validator: (val) {
                                return val.length < 8
                                    ? "Enter maximum 8 digit password"
                                    : null;
                              },hintText: " Confirm Password",
                              maxLength: 15,
                              isPass: true,
                              maxEnforced: true,
                              suffixIcon: Icon(
                                Icons.lock,
                                color: Colors.white,
                                size: 25,
                              ),
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: CustomWidget.appButton(
                            height: 60,
                            size: 20,
                            width: double.infinity,
                            context: context,
                            text: 'SIGN UP',
                            onTap: () {
                              final loginForm = _formKey.currentState;
                              if (loginForm.validate()) {
                                loginForm.save();
                                signIn();
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
                              text: "Have an account?",
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
                                    builder: (context) => LoginPage()));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(
                                text: "SIGN IN ",
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
                ],
              ),
            )));
  }
}
