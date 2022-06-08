import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:manfred_karge/Home.dart';
import 'package:manfred_karge/Login.dart';
import 'package:manfred_karge/Utils/color_utils.dart';
import 'package:manfred_karge/Utils/custom_widget.dart';
import 'package:manfred_karge/sharedpreference/store.dart';
//import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadPicture extends StatefulWidget {
  @override
  _UploadPictureState createState() => _UploadPictureState();
}

class _UploadPictureState extends State<UploadPicture> {
  TextEditingController messageController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  File uploadImage;
  String title, description, imagesUpload;
  GlobalKey<FormState> key = new GlobalKey();
  String val;
  ProgressDialog pr;
  //List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';
  @override
  void initState() {
    super.initState();
    getFunction();
  }

  Future<dynamic> getFunction() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getInt("UserId");
    print(
        "user id-----------------------------------------------------------------------" +
            "$store1");
    return store1;
  }

  // Widget buildGridView() {
  //   return 
  //     AnnotatedRegion<SystemUiOverlayStyle>(
  //       value: SystemUiOverlayStyle(
  //       statusBarColor: ColorUtils.appColor),
  //         child: GridView.count(
  //       crossAxisSpacing: 5,
  //       mainAxisSpacing: 5,
  //       physics: NeverScrollableScrollPhysics(),
  //       shrinkWrap: true,
  //       crossAxisCount: 3,
  //       children: List.generate(images.length, (index) {
  //         Asset asset = images[index];
  //         return Stack(
  //           children: [
  //             Card(
  //               elevation: 6,
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                 ),
  //                 child: ClipRRect(
  //                   borderRadius: BorderRadius.circular(5),
  //                     child: AssetThumb(
  //                     asset: asset,
  //                     width: 300,
  //                     height: 300,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Positioned(
  //                 top: 5,
  //                 left: 5,
  //                 child: GestureDetector(
  //                     onTap: () {
  //                       setState(() {
  //                         images.removeAt(index);
  //                       });
  //                     },
  //                     child: Container(
  //                       height: 25,
  //                       width: 25,
  //                       decoration: BoxDecoration(
  //                         color: ColorUtils.lightOrangeColor,
  //                         shape: BoxShape.circle
  //                       ),
  //                       child: Icon(Icons.close, color: Colors.white, size: 19))))
  //           ],
  //         );
  //       }),
  //     ),
  //   );
  // }

  // Future<void> loadAssets() async {
  //   List<Asset> resultList = <Asset>[];
  //   String error = 'No Error Detected';

  //   try {
  //     resultList = await MultiImagePicker.pickImages(
  //       maxImages: 300,
  //       enableCamera: true,
  //       selectedAssets: images,
  //       cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
  //       materialOptions: MaterialOptions(
  //         actionBarColor: "#C34C22",
  //         actionBarTitle: "Manfred_karge",
  //         allViewTitle: "All Photos",
  //         useDetailsView: false,
  //         selectCircleStrokeColor: "#000000",
  //       ),
  //     );
  //   } on Exception catch (e) {
  //     error = e.toString();
  //   }

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;

  //   setState(() {
  //     images = resultList;
  //     _error = error;
  //   });
  // }

  // final imageDoc = ImagePicker();
  // Future getCameraIdcardFront() async {
  //   final pickedFile = await imageDoc.getImage(source: ImageSource.camera);

  //   setState(() {
  //     uploadImage = File(pickedFile.path);
  //   });
  // }

  // Future getGallaryImageFontIdcard() async {
  //   final pickedFile = await imageDoc.getImage(source: ImageSource.gallery);

  //   setState(() {
  //     uploadImage = File(pickedFile.path);
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
    final String url =
        "http://manfredkarger.ouctus-platform.com/api/servicepost";
    var request = http.MultipartRequest("POST", Uri.parse(url));
    // var request = http.MultipartRequest
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': '$header',
    };
    request.headers.addAll(headers);
    request.fields['title'] = title.toString();
    request.fields['description'] = description.toString();
    //create multipart using filepath, string or bytes
    var imagesOfUser =
        await http.MultipartFile.fromPath("images[]", uploadImage.path);
    request.files.add(imagesOfUser);
    print(request);
    var response = await request.send();
    print(response);

    if (response.statusCode == 200) {
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
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorUtils.lightOrangeColor,
          title: Text(
            "Upload Picture",
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
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
              child: Form(
                key: key,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomWidget.getTextFormField(context,
                                text: "Section 1",
                                keyboardType: TextInputType.text,
                                hintText: "Living room",
                                onSaved: (val) => title = val,
                                height: 60),
                            SizedBox(
                              height: 20.0,
                            ),
                            CustomWidget.getTextFormField(context,
                                text: "Description",
                                onSaved: (val) => description = val,
                                keyboardType: TextInputType.text,
                                hintText: "Add Description",
                                height: 70),
                            SizedBox(
                              height: 0.0,
                            ),
                            // uploadImage == null
                            //     ? Card(
                            //         elevation: 8,
                            //         child: Container(
                            //           height: 100,
                            //           width: 150,
                            //           decoration: BoxDecoration(
                            //               borderRadius:
                            //                   BorderRadius.circular(5.0),
                            //               image: DecorationImage(
                            //                   image: AssetImage(
                            //                       "assets/image/Contemporary-Living-Room-Easy-Functionality.jpg"),
                            //                   fit: BoxFit.cover)),
                            //         ),
                            //       )
                            //     : Card(
                            //         elevation: 8,
                            //         child: ClipRRect(
                            //           borderRadius: BorderRadius.circular(5.0),
                            //           child: Image.file(
                            //             uploadImage,
                            //             height: 100,
                            //             width: 150,
                            //             fit: BoxFit.cover,
                            //           ),
                            //         ),
                            //       ),
                            SizedBox(
                              height: 5.0,
                            ),
                            GestureDetector(
                             // onTap: loadAssets,
                              child: Row(
                                children: [
                                  Card(
                                    elevation: 8,
                                    color: Color(0xffDEA38E),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: Color(0xffFFEAEA),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.black,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Upload Images",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 15.0),
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       setState(() {
                            //         buildUploadSection();
                            //       });
                            //     },
                            //     child: Text(
                            //       "+ Add Section 2",
                            //       style: TextStyle(
                            //           color: ColorUtils.lightOrangeColor,
                            //           fontSize: 18),
                            //     ),
                            //   ),
                            // ),
                          ]),
                      //buildGridView(),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 4.0, right: 4.0, bottom: 20, top: 30),
                        child: CustomWidget.appButton(
                            width: MediaQuery.of(context).size.width,
                            context: context,
                            height: 50,
                            size: 18,
                            text: "Submit",
                            onTap: () {
                              setState(() {
                                if (store1 != null) {
                                  final loginForm = key.currentState;
                                  if (loginForm.validate()) {
                                    loginForm.save();
                                    _asyncFileUpload();
                                  } else {
                                    print("rrrrrrr");
                                  }
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                }
                              });
                            }),
                      ),
                    ]),
              ),
            ),
          ],
        ));
  }

  buildUploadSection() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomWidget.getTextFormField(context,
              text: "Section 1",
              keyboardType: TextInputType.text,
              initialValue: "Living room",
              onSaved: (val) => val = val,
              // hintText: "Living room",
              controller: messageController,
              height: 60),
          SizedBox(
            height: 20.0,
          ),
          uploadImage == null
              ? Text("")
              : Card(
                  elevation: 8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.file(
                      uploadImage,
                      height: 100,
                      width: 150,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
          Row(
            children: [
              Card(
                elevation: 8,
                color: Color(0xffDEA38E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Color(0xffFFEAEA),
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Upload Images",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              "+ Add Section 2",
              style:
                  TextStyle(color: ColorUtils.lightOrangeColor, fontSize: 18),
            ),
          ),
        ]);
      },
    );
  }

  Future<void> buildUploadImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("From where do you want to choose the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () {
                      //  getGallaryImageFontIdcard();

                        Navigator.pop(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                       // getCameraIdcardFront();
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }
}
