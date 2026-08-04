import 'package:flutter/material.dart';
import '../services/api_service.dart';



class CategoriasEventoPage extends StatefulWidget {


  const CategoriasEventoPage({
    super.key
  });



  @override
  State<CategoriasEventoPage> createState()
      => _CategoriasEventoPageState();


}







class _CategoriasEventoPageState
    extends State<CategoriasEventoPage>{



final nomeController =
TextEditingController();



bool salvando = false;



List categorias = [];






@override
void initState(){

super.initState();

carregar();

}




Future<void> carregar() async{


try{


final dados =
await ApiService.categoriasEvento();



setState((){

categorias=dados;

});



}catch(e){

print(e);

}


}






Future<void> salvar() async{


if(nomeController.text.trim().isEmpty){

return;

}



setState((){

salvando=true;

});



try{


await ApiService.post(

"categorias-evento",

{

"nome":
nomeController.text.trim()

}

);



nomeController.clear();



await carregar();



}catch(e){


print(e);


}



setState((){

salvando=false;

});


}







@override
Widget build(BuildContext context){


return Scaffold(


appBar:

AppBar(

title:

const Text(
"Categorias de Evento"
),

),





body:

Padding(


padding:

const EdgeInsets.all(20),



child:

Column(



children:[




TextField(

controller:

nomeController,


decoration:

const InputDecoration(

labelText:
"Nome da categoria",

border:
OutlineInputBorder()

),

),





const SizedBox(
height:20
),






SizedBox(


width:

double.infinity,



child:

ElevatedButton(


onPressed:

salvando
?
null
:
salvar,


child:

const Text(
"Cadastrar"
),


),


),





const SizedBox(
height:20
),





Expanded(


child:

ListView.builder(


itemCount:

categorias.length,



itemBuilder:(context,index){



return Card(


child:

ListTile(


title:

Text(

categorias[index]['nome']

),


),


);



}


),


)




]


),


),


);


}



}