import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manfred_karge/Utils/color_utils.dart';

class CustomWidget {
  static Widget buildLogoImageAndText(
      {BuildContext context, double top, String text}) {
    return Container(
        //color: Colors.red,
        padding: EdgeInsets.only(
          top: top,
        ),
        // height: 170,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 140,
              fit: BoxFit.fitHeight,
            ),
            Text(text,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                )),
          ],
        ));
  }
  static Widget getTextFormField(BuildContext context,
      {TextEditingController controller,
      String labelText,
        String hintText,
         bool isDense =  true, 
        int maxLength,
        int maxLine,
      FormFieldSetter<String> onSaved,
      FormFieldValidator<String> validator,
      bool isPass = false,
       String counterText,
        bool maxEnforced=false,
        String initialValue,
      TextInputType keyboardType: TextInputType.text,
        Icon icon,
      String text,
      double height
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          height: height,
          child: TextFormField(
            controller: controller,
            initialValue: initialValue,
            onSaved: onSaved,
            maxLength: maxLength,
            maxLines: maxLine,
            maxLengthEnforced: maxEnforced,
            obscureText: isPass,
            validator: validator,
            keyboardType: keyboardType,
            
            decoration: InputDecoration(
                isDense: isDense,
            contentPadding: new EdgeInsets.fromLTRB(
                10.0, 10.0, 15.0, 15.0),

              hintText: hintText,
               counterText: counterText,
              fillColor: Color(0xffEFEFF4),
              filled: true,
              hintStyle: TextStyle(
                color: ColorUtils.lightBlue,
                fontSize: 16,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        // CustomWidget.dividerWhite,
      ],
    );
  }
  static Widget getAppThemeTextField(BuildContext context,
      {
        TextEditingController controller,
        String labelText,
        String hintText,
        FormFieldSetter<String> onSaved,
        FormFieldValidator<String> validator,
        int maxLength,
        Icon suffixIcon,
        String counterText,
        bool maxEnforced=false,
        bool isPass = false,
        TextInputType keyboardType: TextInputType.text,
        String text,
        onTap,
        }
        ) {
    return TextFormField(
      style: TextStyle(color: Colors.white,fontSize: 14),
      controller: controller,
      onSaved: onSaved,
      obscureText: isPass,
      validator: validator,
      maxLengthEnforced: maxEnforced,
      maxLength: maxLength,
      keyboardType: keyboardType,
    decoration: InputDecoration(
          contentPadding: new EdgeInsets.fromLTRB(
              10.0, 10.0, 30.0, 30.0),
          fillColor: Color(0xff284E74),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          counterText: counterText,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white,fontSize: 20),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color(0xff284E74)),
            borderRadius: BorderRadius.circular(5.0),),
          suffixIcon: GestureDetector(
            onTap: onTap,child:  suffixIcon,
          )

        )
    );
  }
  static Widget getAppThemeTextFieldIcon(BuildContext context,
      {TextEditingController controller,
        String labelText,
        String hintText,
        FormFieldSetter<String> onSaved,
        FormFieldValidator<String> validator,
        int maxLength,
        Image suffixIcon,
        String counterText,
        bool maxEnforced=false,
        bool isPass = false,
        TextInputType keyboardType: TextInputType.text,
        String text,
      }
      ) {
    return TextFormField(
        style: TextStyle(color: Colors.white,fontSize: 14),
        controller: controller,
        onSaved: onSaved,
        obscureText: isPass,
        validator: validator,
         maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds, 
        maxLengthEnforced: maxEnforced,
        maxLength: maxLength,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            contentPadding: new EdgeInsets.fromLTRB(
                10.0, 10.0, 30.0, 30.0),
            fillColor: Color(0xff284E74),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            counterText: counterText,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white,fontSize: 20),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color(0xff284E74)),
              borderRadius: BorderRadius.circular(5.0),),
            suffixIcon: Padding(padding: EdgeInsets.all(10.0),child:   suffixIcon,),

        )
    );
  }

  static getProfileTextField(BuildContext context,
      {TextEditingController controller,
        String labelText,
        String hintText,
        FormFieldSetter<String> onSaved,
        FormFieldValidator<String> validator,
        bool isPass = false,
        TextInputType keyboardType: TextInputType.text,
        String text,
        String initialValue,
        double height}){
    return Padding(
      padding: const EdgeInsets.only(right: 25,left:25.0,bottom: 10,top:8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text),
          TextFormField(
            initialValue: initialValue,
            controller: controller,
            onSaved: onSaved,
            decoration: new InputDecoration(
              hintText: hintText,
            ),
            keyboardType: keyboardType,
          ),
        ],
      ),
    );
  }
  static Widget appButton(
      {BuildContext context,
      onTap,
      String text,
      double width,
      double height,
      double size}) {
    return Container(
      //margin: EdgeInsets.only(top: 20),
      height: height,
      width: width,
      child: MaterialButton(
        textColor: Colors.white,
        color: ColorUtils.lightOrangeColor,
        //padding: EdgeInsets.all(14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(fontStyle: FontStyle.normal, fontSize: size),
        ),
      ),
    );
  }

  static Widget getBlueBtn({BuildContext context, String text, onTap}) {
    return Container(
      height: MediaQuery.of(context).size.height / 13,
      width: MediaQuery.of(context).size.width - 40,
      child: MaterialButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Colors.blue,
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
