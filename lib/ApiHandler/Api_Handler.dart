import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:manfred_karge/Model/AboutUs.dart';
import 'package:manfred_karge/Model/DashboardModel.dart';
import 'package:manfred_karge/Model/FormsModel.dart';
import 'package:manfred_karge/Model/PartnerModel.dart';
import 'package:manfred_karge/Model/ProfileModel.dart';
import 'package:manfred_karge/Model/TermAndConditionModel.dart';
import 'package:manfred_karge/Model/imprintsModel.dart';
import 'package:manfred_karge/Model/servicesListModel.dart';
import 'package:manfred_karge/sharedpreference/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiHandler{
  static String url = "https://manfredkarger.ouctus-platform.com/";
  static String imageUrl = "https://manfredkarger.ouctus-platform.com"; 
  static Future<DashboardModel> getProductDetails() async {
    try{
      final url = "https://manfredkarger.ouctus-platform.com/api/dashboard";
      final response = await http.get(
        url,
      );
      print(response);
      if (response.statusCode == 200) {
        var getDashboard = jsonDecode(response.body);
        print(response.statusCode);
        print(response.body);
        return DashboardModel.fromJson(getDashboard);
      } else {
        throw Exception();
      }
    }on SocketException {
      print('No Internet connection 😑');
    } on HttpException {
      print("Couldn't find the post 😱");
    } on FormatException {
      print("Bad response format 👎");
    }
    catch(e){
      print(e);
    }
    return DashboardModel();
  }
  static Future<ImprintsModel> getImprints() async {
    try{
      final url = "https://manfredkarger.ouctus-platform.com/api/imprints";
      final response = await http.get(
        url,
      );
      print(response);
      if (response.statusCode == 200) {
        var aboutUs = jsonDecode(response.body);
        print(response.statusCode);
        print(response.body);
        return ImprintsModel.fromJson(aboutUs);
      } else {
        throw Exception();
      }
    }catch(e){
      print(e);
    }
    return ImprintsModel();
  }
  static Future<AboutUsModelPage> getAboutUs() async {
    try{
      final url = "https://manfredkarger.ouctus-platform.com/api/about_us";
      final response = await http.get(
        url,
      );
      print(response);
      if (response.statusCode == 200) {
        var aboutUs = jsonDecode(response.body);
        print(response.statusCode);
        print(response.body);
        return AboutUsModelPage.fromJson(aboutUs);
      } else {
        throw Exception();
      }
    }on SocketException {
      print('No Internet connection 😑');
    } on HttpException {
      print("Couldn't find the post 😱");
    } on FormatException {
      print("Bad response format 👎");
    }
    catch(e){
      print(e);
    }
    return AboutUsModelPage();
  }
  static Future<TermAndCondition> getTermsAndCondition() async {
    try{
      final url = "https://manfredkarger.ouctus-platform.com/api/termscondition";
      final response = await http.get(
        url,
      );
      print(response);
      if (response.statusCode == 200) {
        var aboutUs = jsonDecode(response.body);
        print(response.statusCode);
        print(response.body);
        return TermAndCondition.fromJson(aboutUs);
      } else {
        throw Exception();
      }
    }on SocketException {
      print('No Internet connection 😑');
    } on HttpException {
      print("Couldn't find the post 😱");
    } on FormatException {
      print("Bad response format 👎");
    }
    catch(e){
      print(e);
    }
    return TermAndCondition();
  }
  static Future<FormsModel> getForms() async {
    try{
      final url = "https://manfredkarger.ouctus-platform.com/api/forms";
      final response = await http.get(
        url,
      );
      print(response);
      if (response.statusCode == 200) {
        var aboutUs = jsonDecode(response.body);
        print(response.statusCode);
        print(response.body);
        return FormsModel.fromJson(aboutUs);
      } else {
        throw Exception();
      }
    }on SocketException {
      print('No Internet connection 😑');
    } on HttpException {
      print("Couldn't find the post 😱");
    } on FormatException {
      print("Bad response format 👎");
    }
    catch(e){
      print(e);
    }
    return FormsModel();
  }
  static Future<GetManFredServices> getServices() async {
    try{
      final url = "https://manfredkarger.ouctus-platform.com/api/services";
      final response = await http.get(
        url,
      );
      print(response);
      if (response.statusCode == 200) {
        var aboutUs = jsonDecode(response.body);
        print(response.statusCode);
        print(response.body);
        return  GetManFredServices.fromJson(aboutUs);
      } else {
        throw Exception();

      }
    }on SocketException {
      print('No Internet connection 😑');
    } on HttpException {
      print("Couldn't find the post 😱");
    } on FormatException {
      print("Bad response format 👎");
    }catch(e){
      print(e);
    }
    return  GetManFredServices();
  }

  static Future<PartnersModel > getPartner() async {
    try{
      final url = "https://manfredkarger.ouctus-platform.com/api/partners";
      final response = await http.get(
        url,
      );
      print(response);
      if (response.statusCode == 200) {
        var aboutUs = jsonDecode(response.body);
        print(response.statusCode);
        print(response.body);
        return PartnersModel .fromJson(aboutUs);
      } else {
        throw Exception();
      }
    }on SocketException {
      print('No Internet connection 😑');
    } on HttpException {
      print("Couldn't find the post 😱");
    } on FormatException {
      print("Bad response format 👎");
    }catch(e){
      print(e);
    }
    return PartnersModel();
  }
  static Future<ProfileModel> getProfile() async {
    try {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      store1 = sharedPreferences.getString("token");
      print("token" + "$store1");
      final url = "https://manfredkarger.ouctus-platform.com/api/user";
      final response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $store1"
      });
      print(response);
      if (response.statusCode == 200) {
        final jsonPropertyVault = jsonDecode(response.body);
        print(response.statusCode);
        print(response.body);
        return ProfileModel.fromJson(jsonPropertyVault);
      } else {
        throw Exception();
      }
    } on SocketException {
      print('No Internet connection 😑');
    } on HttpException {
      print("Couldn't find the post 😱");
    } on FormatException {
      print("Bad response format 👎");
    }catch (e) {
      print(e);
    }
    return ProfileModel();
  }
  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        textColor: Colors.white,
        backgroundColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        );
  }





}