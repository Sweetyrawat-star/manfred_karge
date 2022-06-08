import 'package:flutter/material.dart';
import 'package:manfred_karge/Utils/color_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebsitePage extends StatefulWidget {
  final String webUrl;
  WebsitePage({this.webUrl});
  @override
  _WebsitePageState createState() => _WebsitePageState();
}

class _WebsitePageState extends State<WebsitePage> {
  bool _isLoading=true;
  var url;

  @override
  void initState() {
    super.initState();
    url = widget.webUrl;
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorUtils.lightOrangeColor,
          title: Text("Partners",style: TextStyle(color: Colors.white),),
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
        body: ProgressHUD(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Stack(
              children: <Widget>[
                WebView(
                  initialUrl: url,
                  javascriptMode: JavascriptMode.unrestricted,
                  onPageFinished: pageFinishedLoading,
                ),
              ],
            ),
          ),
          inAsyncCall: _isLoading,
          opacity: 0.0,
        ));
  }

  void pageFinishedLoading(String url) {
    setState(() {
      _isLoading = false;
    });
  }
}

class ProgressHUD extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Animation<Color> valueColor;

  ProgressHUD({
    Key key,
    @required this.child,
    @required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.grey,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = new List<Widget>();
    widgetList.add(child);
    if (inAsyncCall) {
      final modal = new Stack(
        children: [
          new Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          new Center(
            child: new CircularProgressIndicator(
              valueColor: valueColor,
            ),
          ),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}