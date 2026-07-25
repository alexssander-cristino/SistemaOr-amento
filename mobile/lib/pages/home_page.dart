import 'package:flutter/material.dart';



class HomePage extends StatelessWidget{


@override

Widget build(BuildContext context){


return Scaffold(


appBar:AppBar(

title:Text(
"Dashboard"
),

),



body:Center(

child:Text(

"Bem vindo ao EventManager",

style:TextStyle(

fontSize:25

),

),

),



);


}


}