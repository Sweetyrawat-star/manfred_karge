import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manfred_karge/Login.dart';
import 'package:manfred_karge/Utils/color_utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ResetPassword extends StatefulWidget {
  String userId;
  ResetPassword({this.userId});
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  ProgressDialog pr;
  String confirmPassword, password;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool showPassword=false;
  bool _showPassword=false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    showPassword = true;
    _showPassword = true;
  }
  Future<void> signUp() async {
    setState(() {
      pr.show();
    });
    var body = ({
      "confirmPassword": confirmPassword.toString(),
      "newPassword": password.toString(),
      "userId": widget.userId,
    });
    String url = "https://manfredkarger.ouctus-platform.com/api/resetpassword";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonResponse;
    var response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("response statusCode ${response.statusCode}");
      print("body$jsonResponse");
      print("response body ${jsonResponse["token"]}");
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });

        var token1 = sharedPreferences.setString(
            "token", jsonResponse["token"].toString());

        print(token1);
        var token2 = sharedPreferences.getString("token");
        print(token2);
        Fluttertoast.showToast(
            msg: "ResetPassword Successful",
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
            decoration: BoxDecoration(
                color: Color(0xff081D32)
            ),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(left:10.0,right: 10,top: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Image.asset("assets/image/Manfred Karger-01white.png"),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          text: "Reset Password",
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
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
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.white,fontSize: 20),
                              suffixIcon: Icon(Icons.lock,color:Colors.white,size: 25,),
                            ))),
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
                              labelText: 'Confirm Password',
                              labelStyle: TextStyle(color: Colors.white,fontSize: 20),
                              suffixIcon: Icon(Icons.lock,color:Colors.white,size: 25,),
                            ))),
                    SizedBox(height: 20,),

                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          child: RaisedButton(
                            color: ColorUtils.lightOrangeColor,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {

                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text('Processing Data')));
                              }
                            },
                            child: Text(
                              'Save',
                              style: TextStyle(color: Colors.white,fontSize: 20),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                side: BorderSide(color: ColorUtils.lightOrangeColor)),
                          ),
                        )),
                    SizedBox(height: 20,),
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
                    SizedBox(height: 15,),
                    Container(
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
                    )
                  ],
                ),
              ),
            ))
    );
  }
}
