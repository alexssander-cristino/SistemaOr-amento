import 'package:flutter/material.dart';
import '../services/api_service.dart';



class CategoriasPage extends StatefulWidget {


  const CategoriasPage({super.key});


  @override
  State<CategoriasPage> createState() => _CategoriasPageState();


}







class _CategoriasPageState extends State<CategoriasPage>{



  List categorias = [];


  bool carregando = true;






  @override
  void initState(){


    super.initState();


    carregar();


  }








  Future<void> carregar() async{



    final dados =

    await ApiService.categorias();




    setState((){


      categorias = dados;


      carregando = false;


    });



  }









  void novaCategoria(){



    final nome =

    TextEditingController();






    showDialog(



      context: context,



      builder:(context){



        return AlertDialog(



          title:
          const Text(
            "Nova Categoria"
          ),





          content:

          TextField(


            controller:nome,


            decoration:

            const InputDecoration(


              labelText:
              "Nome da categoria",


              prefixIcon:
              Icon(Icons.category)


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
              )


            ),







            ElevatedButton(


              onPressed:() async{



                if(nome.text.isEmpty){

                  return;

                }







                bool sucesso =

                await ApiService.criar(



                  "categorias",



                  {


                    "nome":
                    nome.text


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
                        "Categoria cadastrada"
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


      "categorias",


      id



    );






    if(sucesso){



      carregar();



    }



  }













  @override
  Widget build(BuildContext context){



    return Scaffold(




      appBar:

      AppBar(


        title:
        const Text(
          "Categorias"
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
          "Nova"
        ),



        onPressed:
        novaCategoria,



      ),







      body:




      carregando ?



      const Center(

        child:
        CircularProgressIndicator()

      )





      :





      categorias.isEmpty ?



      const Center(

        child:
        Text(
          "Nenhuma categoria cadastrada"
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
          categorias.length,






          itemBuilder:(context,index){





            final categoria =

            categorias[index];







            return Card(



              elevation:4,



              margin:

              const EdgeInsets.only(

                bottom:12

              ),






              child:

              ListTile(






                leading:

                const CircleAvatar(



                  child:
                  Icon(
                    Icons.category
                  )


                ),







                title:

                Text(



                  categoria['nome']

                  ??

                  "Sem nome"



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

                      categoria['id']

                    );



                  },



                ),






              )



            );




          }



        )



      )






    );



  }





}