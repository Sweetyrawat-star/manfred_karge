import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:manfred_karge/Home.dart';
import 'package:manfred_karge/Utils/color_utils.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  PageController controller = PageController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: ColorUtils.appColor,
        ),
        child: Stack(
          children: <Widget>[
            PageView(
              onPageChanged: (value) {
                setState(() {
                  pageIndex = value;
                });
              },
              controller: controller,
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.only(top: 20.0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: double.infinity,
                        // alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: ColorUtils.appColor,
                            image: DecorationImage(
                                image: AssetImage(
                                  'assets/image/on-boarding-1.png',
                                ),
                                fit: BoxFit.fill,
                                alignment: Alignment.center)),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 30.0),
                          child: Padding(
                            padding:EdgeInsets.only(bottom: 30.0),

                              // top: MediaQuery.of(context).size.height-300,
                             // bottom:
                                //  MediaQuery.of(context).size.height - 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'First',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28,
                                        color: ColorUtils.lightOrangeColor),
                                  ),
                                  Text(
                                    'Enjoy like never before from',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14.0),
                                  ),
                                  Text(
                                    'around the globe',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14.0),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Container(
                                        height: 40,
                                        width: 180,
                                        child: RaisedButton(
                                          color: ColorUtils.lightOrangeColor,
                                          onPressed: () {
                                            if (!(controller.page == 2.0))
                                              controller.nextPage(
                                                  duration: Duration(
                                                      milliseconds: 200),
                                                  curve: Curves.linear);
                                            },
                                          child: Text(
                                            'Next',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      5.0),
                                              side: BorderSide(
                                                  color: ColorUtils
                                                      .lightOrangeColor)),
                                        ),
                                      )),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                padding: const EdgeInsets.only(top: 20.0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: ColorUtils.appColor,
                            image: DecorationImage(
                                image: AssetImage(
                                  'assets/image/on-boarding-2.png',
                                ),
                                fit: BoxFit.fill,
                                alignment: Alignment.center)),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 30.0),
                          child: Padding(
                             padding:EdgeInsets.only(bottom: 30.0),

                              // bottom:
                              //     MediaQuery.of(context).size.height - 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Second',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28,
                                        color: ColorUtils.lightOrangeColor),
                                  ),
                                  Text(
                                    'Enjoy like never before from',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14.0),
                                  ),
                                  Text(
                                    'around the globe',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14.0),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Container(
                                        height: 40,
                                        width: 180,
                                        child: RaisedButton(
                                          color: ColorUtils.lightOrangeColor,
                                          onPressed: () {
                                            if (!(controller.page == 2.0))
                                              controller.nextPage(
                                                  duration: Duration(
                                                      milliseconds: 200),
                                                  curve: Curves.linear);
                                          },
                                          child: Text(
                                            'Next',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      5.0),
                                              side: BorderSide(
                                                  color: ColorUtils
                                                      .lightOrangeColor)),
                                        ),
                                      )),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(top: 20.0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: ColorUtils.appColor,
                            image: DecorationImage(
                                image: AssetImage(
                                  'assets/image/on-boarding-3.png',
                                ),
                                fit: BoxFit.fill,
                                alignment: Alignment.center)),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 30.0),
                          child: Padding(
                             padding:EdgeInsets.only(bottom: 30.0),

                              // bottom:
                              //     MediaQuery.of(context).size.height - 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Third',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28,
                                        color: ColorUtils.lightOrangeColor),
                                  ),
                                  Text(
                                    'Enjoy like never before from',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14.0),
                                  ),
                                  Text(
                                    'around the globe',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14.0),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Container(
                                        height: 40,
                                        width: 180,
                                        child: RaisedButton(
                                          color: ColorUtils.lightOrangeColor,
                                          onPressed: () {
                                            if (!(controller.page == 2.0))
                                              controller.nextPage(
                                                  duration: Duration(
                                                      milliseconds: 200),
                                                  curve: Curves.linear);
                                          },
                                          child: Text(
                                            'Next',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      5.0),
                                              side: BorderSide(
                                                  color: ColorUtils
                                                      .lightOrangeColor)),
                                        ),
                                      )),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 1.0,
              child: Container(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Opacity(
                      opacity: pageIndex != 2 ? 1.0 : 0.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                        child: Text(
                          "Skip",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(8.0),
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 2),
                              color:
                                  pageIndex == 0 ? Colors.grey : Colors.white),
                        ),
                        Container(
                          margin: EdgeInsets.all(8.0),
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 2),
                              color:
                                  pageIndex == 1 ? Colors.grey : Colors.white),
                        ),
                        Container(
                          margin: EdgeInsets.all(8.0),
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 2),
                              color:
                                  pageIndex == 2 ? Colors.grey : Colors.white),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        pageIndex != 2
                            ? GestureDetector(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  if (!(controller.page == 2.0))
                                    controller.nextPage(
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.linear);
                                },
                              )
                            : GestureDetector(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()));
                                },
                              )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
