import 'package:flutter/material.dart';

import '../services/api_service.dart';



class ServicosPage extends StatefulWidget {


  const ServicosPage({super.key});


  @override
  State<ServicosPage> createState() =>
      _ServicosPageState();


}






class _ServicosPageState
extends State<ServicosPage>{



List servicos=[];


List categorias=[];


bool carregando=true;






@override
void initState(){

super.initState();

carregar();

}








Future<void> carregar() async{


final s =
await ApiService.servicos();


final c =
await ApiService.categorias();



setState((){


servicos=s;

categorias=c;

carregando=false;


});



}









void novoServico(){



final nome =
TextEditingController();



final descricao =
TextEditingController();



final valor =
TextEditingController();




int? categoriaSelecionada;






showDialog(


context:context,


builder:(context){



return StatefulBuilder(


builder:(context,setModalState){



return AlertDialog(




title:

const Text(
"Novo Serviço"
),






content:

SingleChildScrollView(



child:

Column(



mainAxisSize:

MainAxisSize.min,



children:[





TextField(


controller:nome,


decoration:

const InputDecoration(

labelText:
"Nome do serviço",

prefixIcon:
Icon(Icons.work)

),



),






TextField(


controller:descricao,


maxLines:3,


decoration:

const InputDecoration(

labelText:
"Descrição",

prefixIcon:
Icon(Icons.description)

),



),






TextField(


controller:valor,


keyboardType:

TextInputType.number,


decoration:

const InputDecoration(

labelText:
"Valor",

prefixIcon:
Icon(Icons.attach_money)

),



),







const SizedBox(height:15),






DropdownButtonFormField<int>(



value:
categoriaSelecionada,



decoration:

const InputDecoration(

labelText:
"Categoria",

prefixIcon:
Icon(Icons.category)

),




items:

categorias.map<DropdownMenuItem<int>>((cat){



return DropdownMenuItem(


value:
cat['id'],



child:

Text(

cat['nome']

??

"Sem nome"

),



);



}).toList(),





onChanged:(valor){



setModalState((){


categoriaSelecionada=
valor;



});


},




)






]

)


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





if(categoriaSelecionada==null){

return;

}





bool sucesso =

await ApiService.criar(



"servicos",



{


"nome":

nome.text,



"descricao":

descricao.text,



"valor":

double.tryParse(valor.text)
??
0,



"categoria_id":

categoriaSelecionada





}



);







if(sucesso){



Navigator.pop(context);



carregar();



ScaffoldMessenger.of(context)
.showSnackBar(



const SnackBar(


content:

Text(
"Serviço cadastrado"
)


)


);



}





},



child:

const Text(
"Salvar"
)



)






]



);




}


);




}


);




}









Future<void> excluir(int id) async{



bool sucesso =

await ApiService.deletar(

"servicos",

id

);




if(sucesso){


carregar();


}



}









String dinheiro(dynamic valor){


double numero =

double.tryParse(
valor.toString()
)

??

0;




return

"R\$ ${numero.toStringAsFixed(2).replaceAll(".",",")}";



}









@override
Widget build(BuildContext context){



return Scaffold(




appBar:

AppBar(


title:

const Text(
"Serviços"
),



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

novoServico,



),







body:



carregando



?


const Center(

child:

CircularProgressIndicator()

)






:





RefreshIndicator(




onRefresh:

carregar,





child:

servicos.isEmpty




?





ListView(



children:[



SizedBox(

height:300,



child:

Center(

child:

Text(

"Nenhum serviço cadastrado"

)

)

)



]

)






:







ListView.builder(




padding:

const EdgeInsets.all(15),





itemCount:

servicos.length,






itemBuilder:(context,index){



final servico =

servicos[index];





return Card(



elevation:4,



margin:

const EdgeInsets.only(

bottom:15

),




child:

ListTile(





leading:

const CircleAvatar(


child:

Icon(
Icons.work

)

),







title:

Text(


servico['nome']

??

"Serviço"


),






subtitle:

Column(


crossAxisAlignment:

CrossAxisAlignment.start,



children:[




Text(

"Categoria: ${servico['categoria'] ?? 'Sem categoria'}"

),




Text(

"Valor: ${dinheiro(servico['valor'])}"

),






if(servico['descricao']!=null)

Text(

servico['descricao']

)






]



),







trailing:

IconButton(



icon:

const Icon(

Icons.delete,

color:

Colors.red

),



onPressed:(){



excluir(

servico['id']

);



},



)






)





);



}



)






)





);



}




}