import 'package:flutter/material.dart';

import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';


void main(){

  runApp(const MyApp());

}



class MyApp extends StatelessWidget {


  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {


    return MaterialApp(

debugShowCheckedModeBanner:false,

title:"EventManager",

theme:ThemeData(

primarySwatch:Colors.blue,

),


initialRoute:'/login',


routes:{


'/login':(context)=>LoginPage(),

'/register':(context)=>RegisterPage(),

'/home':(context)=>HomePage(),

},


);

  }
}