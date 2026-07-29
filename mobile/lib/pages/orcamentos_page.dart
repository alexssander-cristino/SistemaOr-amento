import 'package:flutter/material.dart';

import '../services/api_service.dart';

import '../services/pdf_service.dart';



class OrcamentosPage extends StatefulWidget {


  const OrcamentosPage({
    super.key
  });



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


try{



final e =

await ApiService.eventos();




final o =

await ApiService.orcamentos();






setState((){



eventos=e;

orcamentos=o;

carregando=false;



});




}catch(e){



setState((){

carregando=false;

});



mostrarMensagem(
"Erro ao carregar orçamentos"
);



}




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
"Novo Orçamento"
),






content:

DropdownButtonFormField<int>(



value:

eventoSelecionado,



decoration:

const InputDecoration(

labelText:

"Evento",

border:

OutlineInputBorder()

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



setModal((){



eventoSelecionado=v;



});



},



),







actions:[







TextButton(



onPressed:(){



Navigator.pop(context);



},



child:

const Text(
"Cancelar"
)



),







ElevatedButton(



onPressed:() async{



if(eventoSelecionado==null){



mostrarMensagem(
"Selecione um evento"
);



return;



}






try{



await ApiService.post(



"orcamentos",



{


"evento_id":

eventoSelecionado,



"desconto":

0,



"valor_total":

0,



"status":

"pendente"



}



);






Navigator.pop(context);



carregar();





mostrarMensagem(
"Orçamento criado"
);




}catch(e){



mostrarMensagem(
e.toString()
);



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



List servicos = [];



if(orc['servicos'] != null){

servicos =
orc['servicos'];

}

else if(orc['itens'] != null){

servicos =
orc['itens'];

}








double total=0;



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

orc['evento']?['cliente']?['nome']
??
"",




evento:

orc['evento']?['tipo']
??
"",




servicos:

servicos,




total:

total




);



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
"Orçamentos"
),



),







floatingActionButton:

FloatingActionButton.extended(



icon:

const Icon(
Icons.add
),




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

orcamentos.isEmpty



?



const Center(

child:

Text(
"Nenhum orçamento encontrado"
)

)



:



RefreshIndicator(



onRefresh:

carregar,




child:

ListView.builder(



padding:

const EdgeInsets.all(15),




itemCount:

orcamentos.length,





itemBuilder:(context,index){



final o =

orcamentos[index];






return Card(



elevation:

4,




child:

ListTile(





title:

Text(

"Orçamento #${o['id']}"

),






subtitle:

Text(


"Cliente: ${o['evento']?['cliente']?['nome'] ?? ''}\n"

"Evento: ${o['evento']?['tipo'] ?? ''}\n"

"Status: ${o['status'] ?? ''}"



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



),



);



},



),



),



);



}



}