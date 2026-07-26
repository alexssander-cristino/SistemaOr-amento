import 'package:flutter/material.dart';

import '../services/api_service.dart';

import '../services/pdf_service.dart';





class OrcamentosPage extends StatefulWidget {



const OrcamentosPage({super.key});



@override
State<OrcamentosPage> createState()

=> _OrcamentosPageState();



}







class _OrcamentosPageState

extends State<OrcamentosPage>{



List eventos=[];

List orcamentos=[];


bool carregando=true;








@override
void initState(){

super.initState();

carregar();

}







Future<void> carregar() async{


final e =

await ApiService.eventos();



final o =

await ApiService.orcamentos();




setState((){


eventos=e;

orcamentos=o;

carregando=false;


});



}









void novoOrcamento(){



int? eventoSelecionado;



showDialog(


context:context,


builder:(context){



return StatefulBuilder(



builder:(context,setModal){



return AlertDialog(



title:

const Text(

"Novo orçamento"

),






content:

DropdownButtonFormField<int>(



value:

eventoSelecionado,



decoration:

const InputDecoration(

labelText:

"Evento"

),






items:

eventos.map<DropdownMenuItem<int>>((e){



return DropdownMenuItem(



value:

e['id'],



child:

Text(

e['tipo'] ?? ""

),



);



}).toList(),






onChanged:(v){



setModal((){


eventoSelecionado=v;



});



},




),






actions:[





ElevatedButton(



onPressed:() async{





if(eventoSelecionado==null){

return;

}







bool ok =

await ApiService.criar(

"orcamentos",

{


"evento_id":

eventoSelecionado



}



);






if(ok){



Navigator.pop(context);



carregar();




}




},



child:

const Text(

"Gerar"

)



)






]




);



}



);



}



);




}









void gerarPdf(var orc){





List servicos =

orc['servicos'] ?? [];






double total =0;





for(var s in servicos){



total +=

double.tryParse(

s['valor'].toString()

)

??

0;



}






PdfService.gerarOrcamento(



cliente:

orc['cliente'] ?? "",



evento:

orc['evento'] ?? "",



servicos:

servicos,



total:

total



);



}









@override
Widget build(BuildContext context){



return Scaffold(



appBar:

AppBar(



title:

const Text(

"Orçamentos"

)



),






floatingActionButton:

FloatingActionButton.extended(



icon:

const Icon(Icons.add),



label:

const Text(

"Novo"

),



onPressed:

novoOrcamento,



),






body:



carregando



?


const Center(

child:

CircularProgressIndicator()

)



:

ListView.builder(



padding:

const EdgeInsets.all(15),




itemCount:

orcamentos.length,





itemBuilder:(context,index){



final o=

orcamentos[index];





return Card(



elevation:4,



child:

ListTile(





title:

Text(

"Orçamento #${o['id']}"

),





subtitle:

Text(

"Cliente: ${o['cliente'] ?? ''}\n"
"Evento: ${o['evento'] ?? ''}"

),







trailing:

IconButton(



icon:

const Icon(

Icons.picture_as_pdf

),




onPressed:(){



gerarPdf(o);



},



)






)





);



}



)





);



}



}