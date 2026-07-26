import 'package:flutter/material.dart';
import '../services/api_service.dart';



class EventosFormPage extends StatefulWidget{


const EventosFormPage({super.key});


@override
State<EventosFormPage> createState()=>_EventosFormPageState();


}




class _EventosFormPageState extends State<EventosFormPage>{



final tipo =
TextEditingController();


final data =
TextEditingController();


final hora =
TextEditingController();


final local =
TextEditingController();


final convidados =
TextEditingController();





Future<void> salvar() async{



bool sucesso =
await ApiService.criar(

"eventos",

{


"tipo":tipo.text,

"data":data.text,

"hora":hora.text,

"local":local.text,

"quantidade_convidados":
int.tryParse(convidados.text) ?? 0


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
const Text("Novo Evento")

),




body:
Padding(

padding:
const EdgeInsets.all(20),



child:
SingleChildScrollView(

child:
Column(

children:[



TextField(

controller:tipo,

decoration:
const InputDecoration(

labelText:"Tipo do evento"

)

),



TextField(

controller:data,

decoration:
const InputDecoration(

labelText:"Data (AAAA-MM-DD)"

)

),



TextField(

controller:hora,

decoration:
const InputDecoration(

labelText:"Hora"

)

),




TextField(

controller:local,

decoration:
const InputDecoration(

labelText:"Local"

)

),



TextField(

controller:convidados,

keyboardType:
TextInputType.number,

decoration:
const InputDecoration(

labelText:"Quantidade convidados"

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


)


);



}



}