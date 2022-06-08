import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:manfred_karge/Utils/color_utils.dart';
import 'package:manfred_karge/uploadPicture.dart';
import 'package:path_provider/path_provider.dart';

class PdfViewerPage extends StatefulWidget {
  final String url ,urlName;
  PdfViewerPage(
      {this.url,this.urlName});
  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  String localPath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     Future<String> loadPDF() async {
      var response = await http.get("https://manfredkarger.ouctus-platform.com"+widget.url);

      var dir = await getApplicationDocumentsDirectory();
      File file = new File("${dir.path}/data.pdf");
      file.writeAsBytesSync(response.bodyBytes, flush: true);
      return file.path;
    }


    loadPDF().then((value) {
      setState(() {
        localPath = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.lightOrangeColor,
        title: Text(widget.urlName,style: TextStyle(color: Colors.white),),
        centerTitle: true,
        leading:  Padding(
          padding: const EdgeInsets.only(top:10.0,left: 10),
          child: GestureDetector(
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorUtils.lightOrangeColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> UploadPicture()));
        },
        child: Icon(
          Icons.insert_drive_file_rounded,color: Colors.white,
        ),
      ),
      body: localPath != null
          ? PDFView(
        filePath: localPath,
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
