import 'package:flutter/material.dart';


class DashboardCard extends StatelessWidget {


final String titulo;

final String valor;

final IconData icone;

final VoidCallback onTap;




const DashboardCard({

super.key,

required this.titulo,

required this.valor,

required this.icone,

required this.onTap,


});





@override
Widget build(BuildContext context){


return InkWell(


onTap:onTap,


borderRadius:BorderRadius.circular(15),



child:Container(


padding:
const EdgeInsets.all(20),



decoration:

BoxDecoration(

color:Colors.white,

borderRadius:
BorderRadius.circular(15),


boxShadow:[


BoxShadow(

color:Colors.black12,

blurRadius:8

)


]

),





child:Column(


mainAxisAlignment:
MainAxisAlignment.center,


children:[



Icon(

icone,

size:40,

color:Colors.blue,

),




const SizedBox(height:10),




Text(

valor,

style:
const TextStyle(

fontSize:30,

fontWeight:
FontWeight.bold

)

),




Text(

titulo,

style:
const TextStyle(

fontSize:16

)

)



]


),


),


);



}


}