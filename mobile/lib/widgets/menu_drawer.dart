import 'package:flutter/material.dart';

import '../services/api_service.dart';



class MenuDrawer extends StatelessWidget {


  const MenuDrawer({super.key});





  Future<void> sair(BuildContext context) async{


    await ApiService.logout();



    Navigator.pushReplacementNamed(

      context,

      '/login'

    );


  }








  Widget item(

      BuildContext context,

      IconData icone,

      String texto,

      String rota

  ){



    return ListTile(


      leading:

      Icon(icone),



      title:

      Text(texto),



      onTap:(){



        Navigator.pop(context);



        Navigator.pushNamed(

          context,

          rota

        );



      },


    );


  }









  @override
  Widget build(BuildContext context){



    return Drawer(



      child:

      Column(



        children:[





          UserAccountsDrawerHeader(



            decoration:

            const BoxDecoration(

              color:Colors.blue

            ),



            accountName:

            const Text(

              "EventManager"

            ),



            accountEmail:

            const Text(

              "Usuário logado"

            ),



            currentAccountPicture:

            const CircleAvatar(



              child:

              Icon(

                Icons.person,

                size:40

              )



            ),



          ),







          item(

            context,

            Icons.dashboard,

            "Dashboard",

            "/home"

          ),







          item(

            context,

            Icons.people,

            "Clientes",

            "/clientes"

          ),







          item(

            context,

            Icons.event,

            "Eventos",

            "/eventos"

          ),







          item(

            context,

            Icons.category,

            "Categorias",

            "/categorias"

          ),







          item(

            context,

            Icons.work,

            "Serviços",

            "/servicos"

          ),







          item(

            context,

            Icons.attach_money,

            "Orçamentos",

            "/orcamentos"

          ),







          item(

            context,

            Icons.account_circle,

            "Minha Conta",

            "/perfil"

          ),








          const Spacer(),







          ListTile(



            leading:

            const Icon(

              Icons.logout,

              color:Colors.red

            ),



            title:

            const Text(

              "Sair",

              style:

              TextStyle(

                color:Colors.red

              )

            ),



            onTap:(){


              sair(context);


            },



          )






        ]



      )



    );



  }



}