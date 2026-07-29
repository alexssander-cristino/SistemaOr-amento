import 'package:flutter/material.dart';
import '../services/api_service.dart';



class ClientesPage extends StatefulWidget {


  const ClientesPage({
    super.key
  });



  @override
  State<ClientesPage> createState()
      => _ClientesPageState();


}







class _ClientesPageState
    extends State<ClientesPage>{



  List clientes = [];

  bool carregando = true;






  @override
  void initState(){

    super.initState();

    carregar();

  }







  Future<void> carregar() async{


    try{


      final dados =
      await ApiService.clientes();



      if(!mounted)
        return;



      setState((){


        clientes = dados;

        carregando = false;


      });



    }catch(e){



      setState((){

        carregando = false;

      });



      mostrarMensagem(
          "Erro ao carregar clientes\n$e"
      );


    }



  }










  void novoCliente(){



    final nome =
    TextEditingController();



    final email =
    TextEditingController();



    final telefone =
    TextEditingController();







    showDialog(

      context: context,

      builder:(context){


        return AlertDialog(



          title:

          const Text(
              "Novo Cliente"
          ),







          content:

          SingleChildScrollView(



            child:

            Column(


              mainAxisSize:
              MainAxisSize.min,



              children:[





                TextField(

                  controller:
                  nome,


                  decoration:
                  const InputDecoration(

                    labelText:
                    "Nome",

                    prefixIcon:
                    Icon(
                        Icons.person
                    ),

                  ),

                ),






                const SizedBox(
                    height:10
                ),





                TextField(

                  controller:
                  email,


                  keyboardType:
                  TextInputType.emailAddress,


                  decoration:
                  const InputDecoration(

                    labelText:
                    "Email",

                    prefixIcon:
                    Icon(
                        Icons.email
                    ),

                  ),

                ),





                const SizedBox(
                    height:10
                ),






                TextField(

                  controller:
                  telefone,


                  keyboardType:
                  TextInputType.phone,


                  decoration:
                  const InputDecoration(

                    labelText:
                    "Telefone",

                    prefixIcon:
                    Icon(
                        Icons.phone
                    ),

                  ),

                ),



              ],


            ),


          ),








          actions:[






            TextButton(


              onPressed:(){


                Navigator.pop(context);


              },


              child:

              const Text(
                  "Cancelar"
              ),


            ),









            ElevatedButton(



              onPressed:() async{



                if(nome.text.trim().isEmpty){


                  mostrarMensagem(
                      "Informe o nome do cliente"
                  );


                  return;

                }





                try{



                  await ApiService.post(


                    "clientes",


                    {


                      "nome":
                      nome.text.trim(),


                      "email":
                      email.text.trim(),


                      "telefone":
                      telefone.text.trim()


                    },


                  );





                  if(!mounted)
                    return;



                  Navigator.pop(context);



                  carregar();




                  mostrarMensagem(

                      "Cliente cadastrado com sucesso"

                  );




                }catch(e){



                  mostrarMensagem(
                      e.toString()
                  );



                }





              },



              child:

              const Text(
                  "Salvar"
              ),



            )






          ],


        );



      },


    ).then((_) {


      nome.dispose();

      email.dispose();

      telefone.dispose();


    });



  }









  Future<void> excluir(int id) async{



    try{



      await ApiService.delete(

          "clientes/$id"

      );



      carregar();



      mostrarMensagem(

          "Cliente removido"

      );



    }catch(e){



      mostrarMensagem(
          e.toString()
      );


    }



  }









  void mostrarMensagem(String texto){


    ScaffoldMessenger.of(context)
        .showSnackBar(


      SnackBar(

        content:
        Text(texto),

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
            "Clientes"
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
        novoCliente,



      ),







      body:

      carregando


          ?

      const Center(

        child:
        CircularProgressIndicator(),

      )



          :



      clientes.isEmpty



          ?



      const Center(

        child:
        Text(
            "Nenhum cliente cadastrado"
        ),

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
          clientes.length,



          itemBuilder:
              (context,index){



            final cliente =
            clientes[index];



            return Card(



              elevation:
              3,



              margin:
              const EdgeInsets.only(
                  bottom:12
              ),





              child:

              ListTile(



                leading:

                CircleAvatar(


                  child:

                  Text(

                    cliente['nome']
                        .toString()
                        .substring(
                        0,1
                    )
                        .toUpperCase(),

                  ),


                ),







                title:

                Text(

                    cliente['nome']
                        ??
                        "Sem nome"

                ),






                subtitle:

                Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,


                  children:[



                    Text(

                        cliente['email']
                            ??
                            "Sem email"

                    ),



                    Text(

                        cliente['telefone']
                            ??
                            "Sem telefone"

                    ),



                  ],


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

                        cliente['id']

                    );


                  },


                ),



              ),



            );


          },


        ),



      ),



    );



  }



}