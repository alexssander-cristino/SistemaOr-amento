import 'package:flutter/material.dart';
import '../services/api_service.dart';



class ConfiguracoesPage extends StatefulWidget{


const ConfiguracoesPage({super.key});


@override
State<ConfiguracoesPage> createState()=>_ConfiguracoesPageState();


}




class _ConfiguracoesPageState extends State<ConfiguracoesPage>{



dynamic usuario;



@override
void initState(){

super.initState();

carregar();

}




Future<void> carregar() async{


var dados =
await ApiService.usuario();


setState((){

usuario=dados;

});


}






@override
Widget build(BuildContext context){


return Scaffold(


appBar:AppBar(

title:
const Text(
"Minha Conta"
)

),



body:


usuario == null


?

const Center(

child:CircularProgressIndicator()

)



:


Padding(

padding:
const EdgeInsets.all(20),


child:Column(


children:[



const CircleAvatar(

radius:50,

child:Icon(

Icons.person,

size:50

)

),




const SizedBox(height:20),





Text(

usuario['name'] ?? "",

style:
const TextStyle(

fontSize:22,

fontWeight:FontWeight.bold

)

),






Text(

usuario['email'] ?? ""

)





]

)

)



);



}



}