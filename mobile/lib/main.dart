import 'package:flutter/material.dart';

import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/perfil_page.dart';
import 'pages/clientes_page.dart';
import 'pages/eventos_page.dart';
import 'pages/servicos_page.dart';
import 'pages/orcamentos_page.dart';
import 'pages/categorias_page.dart';
import 'pages/configuracoes_page.dart';
import 'pages/cadastrar_cliente_page.dart';
import 'pages/evento_cadastro_page.dart';

import 'services/storage_service.dart';



void main() async{


WidgetsFlutterBinding.ensureInitialized();


String? token = await StorageService.token();


runApp(
MyApp(
logado: token != null,
)
);


}





class MyApp extends StatelessWidget {



final bool logado;



const MyApp({

super.key,

required this.logado

});






@override
Widget build(BuildContext context) {


return MaterialApp(


debugShowCheckedModeBanner:false,


title:"EventManager",



theme:ThemeData(


primarySwatch:Colors.blue,


scaffoldBackgroundColor:
Colors.grey[100],


),






initialRoute:

logado ? '/home' : '/login',








routes:{



'/login':

(context)=>LoginPage(),



'/register':

(context)=>RegisterPage(),



'/home':

(context)=>HomePage(),



'/perfil':

(context)=>PerfilPage(),

'/clientes':(context)=>ClientesPage(),

'/eventos':(context)=>EventosPage(),

'/servicos':(context)=>ServicosPage(),

'/orcamentos':(context)=>OrcamentosPage(),

'/categorias':(context)=>CategoriasPage(),

'/configuracoes':
(context)=>ConfiguracoesPage(),

'/cadastrar_cliente':
(context)=>CadastrarClientePage(),

'/eventos/cadastro':
(context)=>EventoCadastroPage(),


},




);


}


}