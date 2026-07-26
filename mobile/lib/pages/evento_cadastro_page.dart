import 'package:flutter/material.dart';

import '../services/api_service.dart';



class EventoCadastroPage extends StatefulWidget {


  const EventoCadastroPage({super.key});



  @override
  State<EventoCadastroPage> createState() =>
      _EventoCadastroPageState();


}








class _EventoCadastroPageState
extends State<EventoCadastroPage>{



final tipoController =
TextEditingController();



final dataController =
TextEditingController();



final horaController =
TextEditingController();



final localController =
TextEditingController();



final convidadosController =
TextEditingController();



final observacoesController =
TextEditingController();





bool salvando = false;







Future<void> salvar() async{



if(tipoController.text.isEmpty ||
   dataController.text.isEmpty){



ScaffoldMessenger.of(context)
.showSnackBar(



const SnackBar(

content:

Text(
"Preencha os campos obrigatórios"
)

)



);



return;



}







setState((){


salvando=true;


});









bool sucesso =

await ApiService.criar(



"eventos",



{


"tipo":

tipoController.text,



"data":

dataController.text,



"hora":

horaController.text,



"local":

localController.text,



"quantidade_convidados":

int.tryParse(

convidadosController.text

) ?? 0,



"observacoes":

observacoesController.text



}



);







setState((){


salvando=false;


});









if(sucesso){



ScaffoldMessenger.of(context)
.showSnackBar(



const SnackBar(

content:

Text(
"Evento cadastrado com sucesso"
)

)



);




Navigator.pop(context);



}else{



ScaffoldMessenger.of(context)
.showSnackBar(



const SnackBar(

content:

Text(
"Erro ao cadastrar evento"
)

)



);



}



}









Widget campo(

TextEditingController controller,

String texto,

IconData icone

){



return Padding(



padding:

const EdgeInsets.only(bottom:15),



child:

TextField(



controller:

controller,



decoration:

InputDecoration(



labelText:

texto,



prefixIcon:

Icon(icone),



border:

const OutlineInputBorder()



),



),



);



}









@override
Widget build(BuildContext context){



return Scaffold(





appBar:

AppBar(



title:

const Text(

"Novo Evento"

)



),








body:

SingleChildScrollView(



padding:

const EdgeInsets.all(20),




child:

Column(



children:[





campo(

tipoController,

"Tipo do evento",

Icons.event

),






campo(

dataController,

"Data (AAAA-MM-DD)",

Icons.calendar_today

),






campo(

horaController,

"Horário",

Icons.access_time

),






campo(

localController,

"Local",

Icons.location_on

),






campo(

convidadosController,

"Quantidade convidados",

Icons.people

),






campo(

observacoesController,

"Observações",

Icons.description

),







const SizedBox(height:20),









SizedBox(



width:

double.infinity,



height:

50,



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

const CircularProgressIndicator(
color:Colors.white
)



:

const Text(

"Salvar Evento"

),



)



)







]



)



)



);




}



}