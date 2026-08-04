import 'package:flutter/material.dart';


import 'pages/splash_page.dart';

import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/perfil_page.dart';
import 'pages/clientes_page.dart';
import 'pages/eventos_page.dart';
import 'pages/servicos_page.dart';
import 'pages/orcamentos_page.dart';
import 'pages/categorias_page.dart';
import 'pages/categorias_evento_page.dart';
import 'pages/configuracoes_page.dart';
import 'pages/cadastrar_cliente_page.dart';
import 'pages/evento_cadastro_page.dart';






void main() async {


  WidgetsFlutterBinding.ensureInitialized();



  runApp(

    const MyApp()

  );


}









class MyApp extends StatelessWidget {


  const MyApp({

    super.key

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



        appBarTheme:const AppBarTheme(


          elevation:0,


          centerTitle:true,


        ),



      ),







      initialRoute:'/splash',










      routes:{






        '/splash':

        (context)=>const SplashPage(),







        '/login':

        (context)=>LoginPage(),







        '/register':

        (context)=>RegisterPage(),







        '/home':

        (context)=>HomePage(),







        '/perfil':

        (context)=>PerfilPage(),







        '/clientes':

        (context)=>ClientesPage(),







        '/eventos':

        (context)=>EventosPage(),







        '/servicos':

        (context)=>ServicosPage(),







        '/orcamentos':

        (context)=>OrcamentosPage(),







        // Categoria de Serviços

        '/categorias':

        (context)=>CategoriasPage(),







        // Categoria de Eventos

        '/categorias-evento':

        (context)=>const CategoriasEventoPage(),







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