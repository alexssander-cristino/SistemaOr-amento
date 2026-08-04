import 'package:flutter/material.dart';

import '../services/api_service.dart';

import '../widgets/dashboard_card.dart';
import '../widgets/grafico_widget.dart';



class HomePage extends StatefulWidget {


  const HomePage({
    super.key
  });



  @override
  State<HomePage> createState()
      => _HomePageState();


}





class _HomePageState extends State<HomePage>{



int clientes = 0;

int eventos = 0;

int servicos = 0;

int orcamentos = 0;



bool carregando = true;



Map usuario = {};

String? fotoUsuario;





@override
void initState(){

super.initState();

carregarDados();

carregarUsuario();

}







Future<void> carregarDados() async{


try{


final c =
await ApiService.clientes();


final e =
await ApiService.eventos();


final s =
await ApiService.servicos();


final o =
await ApiService.orcamentos();




if(!mounted)
return;



setState((){


clientes =
c.length;


eventos =
e.length;


servicos =
s.length;


orcamentos =
o.length;


carregando=false;


});



}catch(e){


print(e);



setState((){

carregando=false;

});


}



}









Future<void> carregarUsuario() async{


try{


final u =
await ApiService.usuario();



if(!mounted)
return;



setState((){


usuario=u;


fotoUsuario =
u['foto'];


});



}catch(e){


print(
"Erro usuário $e"
);


}



}








void abrir(String rota){


Navigator.pushNamed(
context,
rota

).then((_){


carregarDados();

carregarUsuario();


});


}
void menuCadastro(){


showModalBottomSheet(


context: context,


builder:(context){


return SizedBox(


height:380,


child:Column(


children:[



ListTile(

leading:
const Icon(Icons.person_add),


title:
const Text(
"Cadastrar Cliente"
),


onTap:(){

Navigator.pop(context);

abrir('/clientes');

},

),





ListTile(

leading:
const Icon(Icons.event),


title:
const Text(
"Cadastrar Evento"
),


onTap:(){

Navigator.pop(context);

abrir('/eventos');

},

),





ListTile(

leading:
const Icon(Icons.work),


title:
const Text(
"Cadastrar Serviço"
),


onTap:(){

Navigator.pop(context);

abrir('/servicos');

},

),






ListTile(

leading:
const Icon(Icons.category),


title:
const Text(
"Cadastrar Categoria Serviço"
),


onTap:(){

Navigator.pop(context);

abrir('/categorias');

},

),





ListTile(

leading:
const Icon(Icons.event_available),


title:
const Text(
"Cadastrar Categoria Evento"
),


onTap:(){

Navigator.pop(context);

abrir('/categorias-evento');

},

),




]

),


);


}


);


}









Widget fotoPerfil(){


if(
fotoUsuario != null &&
fotoUsuario!.isNotEmpty
){


return CircleAvatar(


radius:18,


backgroundImage:

NetworkImage(
fotoUsuario!
),


);


}



return const CircleAvatar(


radius:18,


child:

Icon(
Icons.person
),


);


}









Widget drawerMenu(){



return Drawer(



child:

ListView(



children:[




const DrawerHeader(


decoration:

BoxDecoration(

color:
Colors.blue

),



child:

Column(


mainAxisAlignment:

MainAxisAlignment.center,


children:[



Icon(

Icons.event,

size:60,

color:
Colors.white

),




Text(

"EventManager",


style:

TextStyle(

color:
Colors.white,

fontSize:22,

fontWeight:
FontWeight.bold

)

)



]


)


),







ListTile(

leading:
const Icon(Icons.person),


title:
const Text(
"Minha conta"
),


onTap:(){

abrir('/perfil');

},

),






ListTile(

leading:
const Icon(Icons.people),


title:
const Text(
"Clientes"
),


onTap:(){

abrir('/clientes');

},

),






ListTile(

leading:
const Icon(Icons.event),


title:
const Text(
"Eventos"
),


onTap:(){

abrir('/eventos');

},

),






ListTile(

leading:
const Icon(Icons.work),


title:
const Text(
"Serviços"
),


onTap:(){

abrir('/servicos');

},

),






ListTile(

leading:
const Icon(Icons.attach_money),


title:
const Text(
"Orçamentos"
),


onTap:(){

abrir('/orcamentos');

},

),






ListTile(

leading:
const Icon(Icons.category),


title:
const Text(
"Categorias Serviço"
),


onTap:(){

abrir('/categorias');

},

),






ListTile(

leading:
const Icon(Icons.event_available),


title:
const Text(
"Categorias Evento"
),


onTap:(){

abrir('/categorias-evento');

},

),






const Divider(),






ListTile(

leading:

const Icon(

Icons.logout,

color:
Colors.red

),



title:

const Text(
"Sair"
),



onTap:()async{


await ApiService.logout();



Navigator.pushReplacementNamed(

context,

'/login'

);



},



),




]


)


);


}
@override
Widget build(BuildContext context){


return Scaffold(



drawer:

drawerMenu(),






appBar:

AppBar(


title:

const Text(
"Dashboard"
),




actions:[



GestureDetector(


onTap:(){

abrir('/perfil');

},



child:

Padding(


padding:

const EdgeInsets.only(
right:15
),



child:

fotoPerfil(),


),


)



]


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

menuCadastro,


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

carregarDados,



child:


ListView(



padding:

const EdgeInsets.all(20),



children:[







GridView.count(



crossAxisCount:

2,



shrinkWrap:

true,



physics:

const NeverScrollableScrollPhysics(),




crossAxisSpacing:

15,



mainAxisSpacing:

15,




children:[





DashboardCard(


titulo:

"Clientes",



valor:

clientes.toString(),



icone:

Icons.people,



onTap:(){

abrir('/clientes');

},


),






DashboardCard(


titulo:

"Eventos",



valor:

eventos.toString(),



icone:

Icons.event,



onTap:(){

abrir('/eventos');

},


),







DashboardCard(


titulo:

"Serviços",



valor:

servicos.toString(),



icone:

Icons.work,



onTap:(){

abrir('/servicos');

},


),







DashboardCard(


titulo:

"Orçamentos",



valor:

orcamentos.toString(),



icone:

Icons.attach_money,



onTap:(){

abrir('/orcamentos');

},


),





]


),









const SizedBox(

height:30

),








GraficoWidget(



clientes:

clientes,



eventos:

eventos,



servicos:

servicos,



orcamentos:

orcamentos,



)






]


),


),



);



}


}