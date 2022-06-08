import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manfred_karge/Home.dart';
import 'package:manfred_karge/Login.dart';
import 'package:manfred_karge/Utils/color_utils.dart';
import 'package:http/http.dart' as http;
import 'package:manfred_karge/Utils/custom_widget.dart';
import 'package:manfred_karge/sharedpreference/store.dart';
import 'package:manfred_karge/uploadPicture.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool rememberMe = false;
  GlobalKey<FormState> key = new GlobalKey();
  String email, name, mobile, subject, message;
  ProgressDialog pr;
  String _brandDropdownValue;

  void _onRememberMeChanged(bool newValue) => setState(() {
        rememberMe = newValue;

        if (rememberMe) {
        } else {}
      });
  contactUpload() async {
    setState(() {
      pr.show();
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("token");
    print("token" + "$store1");
    var header = "Bearer $store1";
    //create multipart request for POST or PATCH method
    final String url =
        "https://manfredkarger.ouctus-platform.com/api/contact_us";
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(
        url,
      ),
    );
    // var request = http.MultipartRequest
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': '$header',
    };

    request.headers.addAll(headers);
    request.fields['name'] = name.toString();
    request.fields['email'] = email.toString();
    request.fields['mobile'] = mobile.toString();
    request.fields['subject'] = _brandDropdownValue.toString();
    request.fields['message'] = message.toString();
    print(request);
    var response = await request.send();
    print(response);
    setState(() {
      pr.hide();
    });
    Fluttertoast.showToast(
        msg: "Contact save successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue[200],
        textColor: Colors.black,
        fontSize: 16.0);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    return Scaffold(
      backgroundColor: Color(0xffF8F8F8),
      appBar: AppBar(
        backgroundColor: ColorUtils.lightOrangeColor,
        title: Text(
          "Contact Us",
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
              ? ListView(padding: const EdgeInsets.all(10.0), children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    child: Text(
                      "Contact for questions, advice and offers",
                      style: TextStyle(
                          color: ColorUtils.appColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Form(
                    key: key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "TELEPHONE:",
                              style: TextStyle(
                                  color: ColorUtils.appDarkGreyColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "012-779-6878",
                              style: TextStyle(
                                  color: ColorUtils.greyLightColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "MOBILE:",
                              style: TextStyle(
                                  color: ColorUtils.appDarkGreyColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "034-759-6878",
                              style: TextStyle(
                                  color: ColorUtils.greyLightColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "EMAIL:",
                              style: TextStyle(
                                  color: ColorUtils.appDarkGreyColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "INFO@GMAIL.COM",
                              style: TextStyle(
                                  color: ColorUtils.greyLightColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomWidget.getTextFormField(context,
                      text: "Name",
                      keyboardType: TextInputType.text,
                      validator: (val) {
                        return val.length < 1 ? "Enter your name" : null;
                      },
                      onSaved: (val) => name = val,
                      height: 50.0),
                  SizedBox(
                    height: 15,
                  ),
                  CustomWidget.getTextFormField(context,
                      text: "Email Address",
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (val) => email = val,
                      validator: (val) {
                        return val.length < 1 ? "Enter your email" : null;
                      },
                      height: 50.0),
                  SizedBox(
                    height: 15,
                  ),
                  CustomWidget.getTextFormField(context,
                      text: "Phone",
                      maxLength: 10,
                      maxEnforced: true,
                      keyboardType: TextInputType.phone,
                      counterText: "",
                      validator: (val) {
                        return val.length < 10 ? "Enter 10 digit number" : null;
                      },
                      onSaved: (val) => mobile = val,
                      height: 50.0),
                  SizedBox(
                    height: 15.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Subject",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: 45.0,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(
                          left: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffEFEFF4),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: DropdownButton<String>(
                          value: _brandDropdownValue,
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                          items: <String>[
                            'Private Move',
                            'Company relocation',
                            'Clear out',
                            'others'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 1))),
                            );
                          }).toList(),
                          hint: Text('Private Mode'),
                          onChanged: (String value) {
                            setState(() {
                              _brandDropdownValue = value;
                            });
                          },
                          isExpanded: true,
                          iconEnabledColor: Color.fromRGBO(170, 131, 108, 1),
                          underline: Container(
                            height: 1.0,
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.transparent,
                                        width: 0.0))),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  CustomWidget.getTextFormField(context,
                      text: "Comments or message",
                        isDense: true, 
                      validator: (val) {
                        return val.length < 1 ? "Enter your comments" : null;
                      },
                      keyboardType: TextInputType.text,
                       maxLine:null,
                      onSaved: (val) => message = val,
                      height: 50),
                
                      
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                                checkColor: Colors.orange,
                                activeColor: Colors.black,
                                value: rememberMe,
                                onChanged: _onRememberMeChanged),
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                width: 360,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Please confirm that you have read our",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          "privacy police.",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  ColorUtils.lightOrangeColor),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Your agree that your details and data will be collected",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      "and stored electornically to answer the request",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 4.0, right: 4.0, bottom: 20),
                    child: CustomWidget.appButton(
                        width: MediaQuery.of(context).size.width,
                        context: context,
                        height: 50,
                        text: "Send",
                        
                        onTap: () {
                            if (store1 != null) {
                              final loginForm = key.currentState;
                              if (loginForm.validate()) {
                                loginForm.save();
                                contactUpload();
                              } else {
                                print("rrrrrrr");
                              }
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            }
                       
                        }
                        ),
                  ),
                ])
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
