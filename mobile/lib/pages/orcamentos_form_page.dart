import 'package:flutter/material.dart';
import '../services/api_service.dart';



class OrcamentosFormPage extends StatefulWidget{


const OrcamentosFormPage({super.key});


@override
State<OrcamentosFormPage> createState()=>_OrcamentosFormPageState();


}





class _OrcamentosFormPageState extends State<OrcamentosFormPage>{



final cliente =
TextEditingController();


final evento =
TextEditingController();


final valor =
TextEditingController();





Future<void> salvar() async{


bool sucesso =
await ApiService.criar(

"orcamentos",

{


"cliente_id":
int.tryParse(cliente.text) ?? 0,


"evento_id":
int.tryParse(evento.text) ?? 0,


"valor_total":
double.tryParse(valor.text) ?? 0,


"status":
"pendente"


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
const Text("Novo Orçamento")

),



body:
Padding(

padding:
const EdgeInsets.all(20),



child:
Column(

children:[



TextField(

controller:cliente,

keyboardType:
TextInputType.number,

decoration:
const InputDecoration(

labelText:"ID Cliente"

)

),




TextField(

controller:evento,

keyboardType:
TextInputType.number,

decoration:
const InputDecoration(

labelText:"ID Evento"

)

),




TextField(

controller:valor,

keyboardType:
TextInputType.number,

decoration:
const InputDecoration(

labelText:"Valor Total"

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