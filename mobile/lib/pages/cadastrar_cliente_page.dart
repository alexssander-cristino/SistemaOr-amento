import 'package:flutter/material.dart';
import '../services/api_service.dart';


class CadastrarClientePage extends StatefulWidget {


  const CadastrarClientePage({super.key});


  @override
  State<CadastrarClientePage> createState()
  => _CadastrarClientePageState();

}



class _CadastrarClientePageState
extends State<CadastrarClientePage>{


final nomeController =
TextEditingController();


final emailController =
TextEditingController();


final telefoneController =
TextEditingController();





bool salvando = false;





Future<void> salvar() async{


if(nomeController.text.isEmpty){

mostrarMensagem(
"Informe o nome"
);

return;

}



setState((){

salvando=true;

});




bool sucesso =
await ApiService.criar(

"clientes",

{


"nome":
nomeController.text,


"email":
emailController.text,


"telefone":
telefoneController.text


}

);





setState((){

salvando=false;

});





if(sucesso){


mostrarMensagem(
"Cliente cadastrado"
);



Navigator.pop(context);



}else{


mostrarMensagem(
"Erro ao cadastrar"
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



appBar:AppBar(

title:
const Text(
"Cadastrar Cliente"
)

),




body:Padding(


padding:
const EdgeInsets.all(20),



child:Column(


children:[




TextField(

controller:
nomeController,

decoration:
const InputDecoration(

labelText:
"Nome",

border:
OutlineInputBorder()

)

),




const SizedBox(height:15),




TextField(

controller:
emailController,

decoration:
const InputDecoration(

labelText:
"Email",

border:
OutlineInputBorder()

)

),





const SizedBox(height:15),





TextField(

controller:
telefoneController,

decoration:
const InputDecoration(

labelText:
"Telefone",

border:
OutlineInputBorder()

)

),






const SizedBox(height:25),






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

salvando

?

const CircularProgressIndicator()

:

const Text(
"Salvar"
)



)



)





]


)


)



);



}



}