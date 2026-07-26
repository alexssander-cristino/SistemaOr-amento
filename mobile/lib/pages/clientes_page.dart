import 'package:flutter/material.dart';
import '../services/api_service.dart';


class ClientesPage extends StatefulWidget {

  const ClientesPage({super.key});


  @override
  State<ClientesPage> createState() => _ClientesPageState();

}




class _ClientesPageState extends State<ClientesPage>{


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



      setState((){


        clientes = dados;

        carregando = false;


      });



    }catch(e){


      setState((){

        carregando=false;

      });


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

                  controller:nome,

                  decoration:
                  const InputDecoration(

                    labelText:
                    "Nome",

                    prefixIcon:
                    Icon(Icons.person)

                  ),

                ),





                const SizedBox(
                  height:10
                ),





                TextField(

                  controller:email,

                  keyboardType:
                  TextInputType.emailAddress,


                  decoration:
                  const InputDecoration(

                    labelText:
                    "Email",

                    prefixIcon:
                    Icon(Icons.email)

                  ),

                ),






                const SizedBox(
                  height:10
                ),





                TextField(

                  controller:telefone,

                  keyboardType:
                  TextInputType.phone,


                  decoration:
                  const InputDecoration(

                    labelText:
                    "Telefone",

                    prefixIcon:
                    Icon(Icons.phone)

                  ),

                ),



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



                if(nome.text.isEmpty){



                  ScaffoldMessenger.of(context)
                  .showSnackBar(


                    const SnackBar(

                      content:
                      Text(
                        "Informe o nome do cliente"
                      )

                    )

                  );


                  return;


                }







                bool sucesso =
                await ApiService.criar(


                  "clientes",


                  {


                    "nome":
                    nome.text,


                    "email":
                    email.text,


                    "telefone":
                    telefone.text


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
                        "Cliente cadastrado com sucesso"
                      )

                    )

                  );



                }else{



                  ScaffoldMessenger.of(context)
                  .showSnackBar(


                    const SnackBar(

                      content:
                      Text(
                        "Erro ao cadastrar cliente"
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









  Future<void> excluir(int id) async{


    bool sucesso =
    await ApiService.deletar(
      "clientes",
      id
    );



    if(sucesso){


      carregar();


      ScaffoldMessenger.of(context)
      .showSnackBar(


        const SnackBar(

          content:
          Text(
            "Cliente removido"
          )

        )

      );


    }


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

      carregando ?


      const Center(

        child:
        CircularProgressIndicator()

      )



      :

      clientes.isEmpty ?


      const Center(

        child:
        Text(
          "Nenhum cliente cadastrado"
        )

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



          itemBuilder:(context,index){



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
                    .substring(0,1)
                    .toUpperCase()

                  )


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

                      cliente['id']

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