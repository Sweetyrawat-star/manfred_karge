import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:manfred_karge/Home.dart';
import 'package:manfred_karge/Login.dart';
import 'package:manfred_karge/Utils/color_utils.dart';
import 'dart:math' as math;
import 'package:manfred_karge/Utils/custom_widget.dart';
import 'package:manfred_karge/sharedpreference/store.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadDocument extends StatefulWidget {
  @override
  _UploadDocumentState createState() => _UploadDocumentState();
}

class _UploadDocumentState extends State<UploadDocument> {
  TextEditingController messageController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  File uploadImage;
  String title,description,imagesUpload;
  GlobalKey<FormState> key = new GlobalKey();
  String val;
  ProgressDialog pr;
  String _fileName;
  String _path;
  Map<String, String> _paths;
  String _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  bool _hasValidMime = false;
  FileType _pickingType;
  TextEditingController _controller = new TextEditingController();
  String path;

  @override
  void initState() {
    super.initState();
    getFunction();
    _controller.addListener(() => _extension = _controller.text);
  }

  // void _openFileExplorer() async {
  //   if (_pickingType != FileType.custom || _hasValidMime) {
  //     setState(() => _loadingPath = true);
  //     try {
  //       if (_multiPick) {
  //         _path = null;
  //         _paths = await FilePicker.getMultiFilePath(
  //           type: FileType.custom,
  //           allowedExtensions: ['pdf','docx'], );
  //       } else {
  //         _paths = null;
  //         _path = await FilePicker.getFilePath(
  //           type: FileType.custom,
  //           allowedExtensions: ['pdf','docx'], );
  //       }
  //     } on PlatformException catch (e) {
  //       print("Unsupported operation" + e.toString());
  //     }
  //     if (!mounted) return;
  //     setState(() {
  //       _loadingPath = false;
  //       _fileName = _path != null
  //           ? _path.split('/').last
  //           : _paths != null ? _paths.keys.toString() : '...';
  //     });
  //   }
  // }
  Future<dynamic> getFunction() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getInt("UserId");
    print("user id-----------------------------------------------------------------------" +"$store1");
    return store1;
  }
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
    final String url = "https://manfredkarger.ouctus-platform.com/api/servicepost";
    var request = http.MultipartRequest("POST", Uri.parse(url));
    // var request = http.MultipartRequest
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': '$header',
    };
    request.headers.addAll(headers);
    request.fields['title'] = "";
    request.fields['description'] = "";
    //create multipart using filepath, string or bytes
    var imagesOfUser =
    await http.MultipartFile.fromPath("images[]", path);
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
            "Upload Document",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10),
            child:GestureDetector(
              onTap: (){
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
        backgroundColor: Color(0xffF4F4F4),
        body:   OfflineBuilder(
          connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
              ) {
            final bool connected = connectivity != ConnectivityResult.none;
            return connected? Stack(
              fit: StackFit.expand,
              children: <Widget>[
                SingleChildScrollView(
                  child: Form(
                    key: key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap:(){
                          // _openFileExplorer();
                          },
                          child: Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            color: Color(0xffEFEFF4),
                            child: Padding(
                              padding: const EdgeInsets.all(40.0),
                              child: Container(
                                  height: 120.0,
                                  width: 100.0,
                                  child: CustomPaint(
                                      painter: DashBorderPainter(
                                          color: Colors.grey[400],
                                          strokeWidth: 1.5,
                                          gap: 4.0),
                                      child: Column(children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(top: 10.0),
                                          child: Image.asset(
                                            "assets/image/upload.png",
                                            height: 80,
                                            width: 100,
                                          ),
                                        ),
                                        Text(
                                          "Upload Document",
                                          style: TextStyle(
                                              color: ColorUtils.lightOrangeColor,
                                              fontSize: 19),
                                        ),
                                        SizedBox(height:6,),
                                      ]))),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              new Builder(
                                builder: (BuildContext context) => _loadingPath
                                    ? Padding(
                                    padding: const EdgeInsets.only(bottom: 10.0),
                                    child: const CircularProgressIndicator())
                                    : _path != null || _paths != null
                                    ? new Container(
                                  padding: const EdgeInsets.only(bottom: 30.0),
                                  child: new ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: _paths != null && _paths.isNotEmpty
                                        ? _paths.length
                                        : 1,
                                    itemBuilder: (BuildContext context, int index) {
                                      final bool isMultiPath =
                                          _paths != null && _paths.isNotEmpty;
                                       final String name = 'File $index: ' +
                                          (isMultiPath
                                              ? _paths.keys.toList()[index]
                                              : _fileName ?? '...');
                                      path = isMultiPath
                                          ? _paths.values.toList()[index].toString()
                                          : _path;

                                      return new ListTile(
                                        title: new Text(
                                          name,
                                        ),
                                        subtitle: new Text(path),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                    new Divider(),
                                  ),
                                )
                                    : new Container(),
                              ),
                              SizedBox(height: 30,),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0, right: 4.0,bottom: 20),
                            child: CustomWidget.appButton(
                                width: MediaQuery.of(context).size.width,
                                context: context,
                                height: 50,
                                text: "Upload",
                                size: 18,
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
                                              builder: (context) =>
                                                  LoginPage()));
                                    }
                                  });


                                }),
                          ),


                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            )  :Center(
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

class DashBorderPainter extends CustomPainter {
  double strokeWidth;
  Color color;
  double gap;

  DashBorderPainter(
      {this.strokeWidth = 5.0, this.color = Colors.red, this.gap = 5.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double x = size.width;
    double y = size.height;

    Path _topPath = getDashedPath(
      a: math.Point(0, 0),
      b: math.Point(x, 0),
      gap: gap,
    );

    Path _rightPath = getDashedPath(
      a: math.Point(x, 0),
      b: math.Point(x, y),
      gap: gap,
    );

    Path _bottomPath = getDashedPath(
      a: math.Point(0, y),
      b: math.Point(x, y),
      gap: gap,
    );

    Path _leftPath = getDashedPath(
      a: math.Point(0, 0),
      b: math.Point(0.001, y),
      gap: gap,
    );

    canvas.drawPath(_topPath, dashedPaint);
    canvas.drawPath(_rightPath, dashedPaint);
    canvas.drawPath(_bottomPath, dashedPaint);
    canvas.drawPath(_leftPath, dashedPaint);
  }

  Path getDashedPath({
    @required math.Point<double> a,
    @required math.Point<double> b,
    @required gap,
  }) {
    Size size = Size(b.x - a.x, b.y - a.y);
    Path path = Path();
    path.moveTo(a.x, a.y);
    bool shouldDraw = true;
    math.Point currentPoint = math.Point(a.x, a.y);

    num radians = math.atan(size.height / size.width);

    num dx = math.cos(radians) * gap < 0
        ? math.cos(radians) * gap * -1
        : math.cos(radians) * gap;

    num dy = math.sin(radians) * gap < 0
        ? math.sin(radians) * gap * -1
        : math.sin(radians) * gap;

    while (currentPoint.x <= b.x && currentPoint.y <= b.y) {
      shouldDraw
          ? path.lineTo(currentPoint.x, currentPoint.y)
          : path.moveTo(currentPoint.x, currentPoint.y);
      shouldDraw = !shouldDraw;
      currentPoint = math.Point(
        currentPoint.x + dx,
        currentPoint.y + dy,
      );
    }
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
