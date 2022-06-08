import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _filePath;
  

  void getFilePath() async {
   try {
     FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.custom,
          allowedExtensions: ['jpg', 'pdf', 'doc'],);
if(result != null) {
   List<File> files = result.paths.map((path) => File(path)).toList();   
   PlatformFile file = result.files.first;
   print(file.name);
   print(file.bytes);
   print(file.size);
   print(file.extension);
   print(file.path);

} else {
   // User canceled the picker
}       
    } on PlatformException catch (e) {
      print("Error while picking the file: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('File Picker Example'),
      ),
      body: new Center(
        child: _filePath == null
            ? new Text('No file selected.')
            : new Text('Path' + _filePath),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: getFilePath,
        tooltip: 'Select file',
        child: new Icon(Icons.sd_storage),
      ),
    );
  }
}