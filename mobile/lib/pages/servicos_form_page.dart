import 'package:flutter/material.dart';
import '../services/api_service.dart';



class ServicosFormPage extends StatefulWidget{


const ServicosFormPage({super.key});


@override
State<ServicosFormPage> createState()=>_ServicosFormPageState();


}




class _ServicosFormPageState extends State<ServicosFormPage>{



final nome =
TextEditingController();


final descricao =
TextEditingController();


final valor =
TextEditingController();






Future<void> salvar() async{


bool sucesso =
await ApiService.criar(

"servicos",

{


"nome":nome.text,

"descricao":descricao.text,

"valor":
double.tryParse(valor.text) ?? 0


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
const Text("Novo Serviço")

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

controller:descricao,

decoration:
const InputDecoration(

labelText:"Descrição"

)

),



TextField(

controller:valor,

keyboardType:
TextInputType.number,

decoration:
const InputDecoration(

labelText:"Valor"

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