import 'dart:async';

import 'package:firebasetodoapps/screens/login_screen.dart';
import 'package:firebasetodoapps/screens/tabs_screens.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
GetStorage _getStorage=GetStorage();

  openNextPage(BuildContext context){
    Timer(Duration(milliseconds: 2000), () {
      if(_getStorage.read('token')==null||_getStorage.read('token')==''){
        Navigator.pushReplacementNamed(context, LoginScreen.id);
      }else{
        Navigator.pushReplacementNamed(context, TabsScreen.id);
      }
    });
  }
  @override
  void initState() {
    openNextPage(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
