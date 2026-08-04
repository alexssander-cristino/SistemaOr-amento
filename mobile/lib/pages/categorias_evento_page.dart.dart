import 'package:flutter/material.dart';
import '../services/api_service.dart';


class CategoriasEventoPage extends StatefulWidget {

  const CategoriasEventoPage({super.key});


  @override
  State<CategoriasEventoPage> createState()
      => _CategoriasEventoPageState();

}



class _CategoriasEventoPageState
    extends State<CategoriasEventoPage>{


final nome =
TextEditingController();


bool salvando = false;


List categorias = [];




@override
void initState(){

super.initState();

carregar();

}



Future<void> carregar() async{


final dados =
await ApiService.categoriasEvento();


setState((){

categorias = dados;

});


}





Future<void> salvar() async{


if(nome.text.trim().isEmpty){

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
nome.text.trim()

}

);



nome.clear();


await carregar();



ScaffoldMessenger.of(context)
.showSnackBar(

const SnackBar(
content:
Text(
"Categoria cadastrada"
)
)

);



}catch(e){


ScaffoldMessenger.of(context)
.showSnackBar(

SnackBar(
content:
Text(
e.toString()
)
)

);


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
nome,

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


final item =
categorias[index];


return Card(

child:

ListTile(

title:

Text(
item['nome']
),

),

);


}

),

)


]


)

)


);


}


}