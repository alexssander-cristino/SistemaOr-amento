import 'dart:async';

import 'package:flutter/material.dart';

import '../services/storage_service.dart';



class SplashPage extends StatefulWidget {


  const SplashPage({super.key});



  @override
  State<SplashPage> createState() => _SplashPageState();


}





class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {



  late AnimationController controller;

  late Animation<double> scale;





  @override
  void initState(){


    super.initState();



    controller = AnimationController(


      vsync:this,


      duration:const Duration(seconds:2),


    );



    scale = CurvedAnimation(


      parent:controller,


      curve:Curves.elasticOut,


    );



    controller.forward();



    iniciar();


  }







  Future<void> iniciar() async{


    await Future.delayed(

      const Duration(seconds:3),

    );



    String? token = await StorageService.token();



    if(!mounted) return;



    Navigator.pushReplacementNamed(

      context,

      token != null

          ? '/home'

          : '/login',

    );


  }








  @override
  void dispose(){


    controller.dispose();


    super.dispose();


  }









  @override
  Widget build(BuildContext context){



    return Scaffold(



      body:Container(



        width:double.infinity,

        height:double.infinity,





        decoration:const BoxDecoration(



          gradient:LinearGradient(



            colors:[


              Color(0xff121212),

              Color(0xff1E1E1E),

              Color(0xff3A2A00),


            ],



            begin:Alignment.topCenter,

            end:Alignment.bottomCenter,


          ),



        ),






        child:Center(



          child:ScaleTransition(



            scale:scale,



            child:Column(



              mainAxisAlignment:MainAxisAlignment.center,



              children:[






                // LOGO QUADRADA

                Container(



                  padding:const EdgeInsets.all(20),



                  decoration:BoxDecoration(



                    color:Colors.white,



                    borderRadius:BorderRadius.circular(20),



                    boxShadow:[



                      BoxShadow(



                        color:Colors.black.withOpacity(0.35),



                        blurRadius:25,


                        offset:const Offset(0,12),



                      ),



                    ],



                  ),




                  child:Image.asset(



                    "assets/icon/icon.png",



                    width:150,



                  ),



                ),








                const SizedBox(height:35),







                const Text(



                  "EventManager",



                  style:TextStyle(



                    color:Colors.white,


                    fontSize:34,


                    fontWeight:FontWeight.bold,


                    letterSpacing:1.5,



                  ),



                ),







                const SizedBox(height:12),







                const Text(



                  "Gestão inteligente de eventos",



                  style:TextStyle(



                    color:Colors.amber,


                    fontSize:16,


                    fontWeight:FontWeight.w500,



                  ),



                ),







                const SizedBox(height:55),







                const SizedBox(



                  width:35,

                  height:35,



                  child:CircularProgressIndicator(



                    strokeWidth:3,


                    color:Colors.amber,


                  ),



                ),







                const SizedBox(height:30),







                Text(



                  "Preparando seu ambiente...",



                  style:TextStyle(



                    color:Colors.white.withOpacity(0.7),



                    fontSize:14,



                  ),



                ),







                const SizedBox(height:45),







                Text(



                  "v1.0.0",



                  style:TextStyle(



                    color:Colors.white.withOpacity(0.4),



                    fontSize:12,


                  ),



                ),





              ],



            ),



          ),



        ),



      ),



    );


  }


}