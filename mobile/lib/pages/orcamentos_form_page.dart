import 'package:flutter/material.dart';
import '../services/api_service.dart';



class OrcamentosFormPage extends StatefulWidget {


  const OrcamentosFormPage({
    super.key
  });



  @override
  State<OrcamentosFormPage> createState()
      => _OrcamentosFormPageState();


}







class _OrcamentosFormPageState
extends State<OrcamentosFormPage>{



List clientes=[];

List eventos=[];



bool carregando=true;



int? clienteSelecionado;

int? eventoSelecionado;



final valor =
TextEditingController();





@override
void initState(){

super.initState();

carregar();


}








Future<void> carregar() async{


try{


clientes =
await ApiService.clientes();


eventos =
await ApiService.eventos();



setState((){

carregando=false;


});



}catch(e){



setState((){

carregando=false;

});



}



}








Future<void> salvar() async{



if(clienteSelecionado==null ||
eventoSelecionado==null){


mostrarMensagem(
"Selecione cliente e evento"
);


return;


}







try{



await ApiService.post(



"orcamentos",



{


"cliente_id":

clienteSelecionado,



"evento_id":

eventoSelecionado,



"valor_total":

double.tryParse(
valor.text
) ?? 0,



"status":

"pendente"



}



);






mostrarMensagem(

"Orçamento criado"

);



Navigator.pop(context);






}catch(e){



mostrarMensagem(

e.toString()

);



}




}









void mostrarMensagem(String texto){


ScaffoldMessenger.of(context)
.showSnackBar(


SnackBar(

content:

Text(texto)

)


);



}









@override
Widget build(BuildContext context){



return Scaffold(




appBar:

AppBar(

title:

const Text(

"Novo Orçamento"

),

),






body:



carregando



?



const Center(

child:

CircularProgressIndicator()

)





:



SingleChildScrollView(



padding:

const EdgeInsets.all(20),






child:

Column(



children:[






DropdownButtonFormField<int>(



value:

clienteSelecionado,



decoration:

const InputDecoration(

labelText:

"Cliente",

border:

OutlineInputBorder(),

prefixIcon:

Icon(
Icons.person
)

),




items:

clientes.map<DropdownMenuItem<int>>(

(c){



return DropdownMenuItem(



value:

c['id'],



child:

Text(

c['nome'] ?? ""

),


);



}

).toList(),




onChanged:(v){



setState((){

clienteSelecionado=v;


});



},



),






const SizedBox(
height:20
),








DropdownButtonFormField<int>(



value:

eventoSelecionado,



decoration:

const InputDecoration(

labelText:

"Evento",

border:

OutlineInputBorder(),

prefixIcon:

Icon(
Icons.event
)

),




items:

eventos.map<DropdownMenuItem<int>>(

(e){



return DropdownMenuItem(



value:

e['id'],



child:

Text(

e['tipo'] ?? ""

),


);



}

).toList(),




onChanged:(v){



setState((){

eventoSelecionado=v;


});



},



),







const SizedBox(
height:20
),








TextField(



controller:

valor,



keyboardType:

TextInputType.number,



decoration:

const InputDecoration(

labelText:

"Valor Total",

border:

OutlineInputBorder(),

prefixIcon:

Icon(
Icons.attach_money
)

),



),







const SizedBox(
height:30
),








SizedBox(



width:

double.infinity,



height:

50,



child:

ElevatedButton(



onPressed:

salvar,



child:

const Text(

"Salvar Orçamento"

),



),



)







]



)



)



);



}



}