import 'package:flutter/material.dart';
import '../services/api_service.dart';



class ClientesFormPage extends StatefulWidget{


const ClientesFormPage({super.key});


@override
State<ClientesFormPage> createState()=>_ClientesFormPageState();


}



class _ClientesFormPageState extends State<ClientesFormPage>{



final nome =
TextEditingController();


final email =
TextEditingController();


final telefone =
TextEditingController();





Future<void> salvar() async{


bool sucesso =
await ApiService.criar(

"clientes",

{

"nome":nome.text,

"email":email.text,

"telefone":telefone.text

}


);



if(sucesso){


Navigator.pop(context);


}



}







@override
Widget build(BuildContext context){


return Scaffold(


appBar:
AppBar(

title:
const Text("Novo Cliente")

),



body:
Padding(

padding:
const EdgeInsets.all(20),



child:
Column(

children:[



TextField(

controller:nome,

decoration:
const InputDecoration(

labelText:"Nome"

)

),



TextField(

controller:email,

decoration:
const InputDecoration(

labelText:"Email"

)

),




TextField(

controller:telefone,

decoration:
const InputDecoration(

labelText:"Telefone"

)

),




const SizedBox(height:30),




ElevatedButton(

onPressed:salvar,

child:
const Text("Salvar")

)



]

)


)


);


}


}