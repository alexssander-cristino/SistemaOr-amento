import 'package:flutter/material.dart';
import '../services/api_service.dart';


class CategoriasPage extends StatefulWidget {

  const CategoriasPage({
    super.key
  });


  @override
  State<CategoriasPage> createState()
      => _CategoriasPageState();

}





class _CategoriasPageState
    extends State<CategoriasPage> {



  List categorias = [];

  List filtro = [];

  bool carregando = true;


  final pesquisaController =
      TextEditingController();







  @override
  void initState(){

    super.initState();

    carregar();

  }






  @override
  void dispose(){

    pesquisaController.dispose();

    super.dispose();

  }







  Future<void> carregar() async {


    try{


      final dados =
      await ApiService.categorias();



      setState((){


        categorias = dados;

        filtro = dados;

        carregando = false;


      });



    }catch(e){


      setState((){

        carregando = false;

      });


      mostrarMensagem(
          "Erro ao carregar categorias"
      );


    }


  }







  void pesquisar(String texto){



    if(texto.isEmpty){


      setState((){

        filtro = categorias;

      });


      return;

    }




    setState((){


      filtro =
          categorias.where((categoria){


            return categoria['nome']
                .toString()
                .toLowerCase()
                .contains(
                texto.toLowerCase()
            );


          }).toList();



    });



  }








  void abrirCadastro({
    Map? categoria
  }){


    final nome =
    TextEditingController(

      text:
      categoria?['nome'] ?? "",

    );





    showDialog(

      context: context,

      builder: (_){



        return AlertDialog(


          title:
          Text(

            categoria == null
                ?
            "Nova Categoria"
                :
            "Editar Categoria",

          ),




          content:

          TextField(

            controller:
            nome,

            decoration:
            const InputDecoration(

              labelText:
              "Nome",

              prefixIcon:
              Icon(Icons.category),

            ),

          ),





          actions:[



            TextButton(

              child:
              const Text(
                  "Cancelar"
              ),

              onPressed: (){

                Navigator.pop(context);

              },

            ),






            ElevatedButton(


              child:
              const Text(
                  "Salvar"
              ),




              onPressed: () async {



                if(nome.text.trim().isEmpty)
                  return;



                try{



                  if(categoria == null){



                    await ApiService.post(

                      "categorias",

                      {

                        "nome":
                        nome.text.trim()

                      },

                    );



                  }else{



                    await ApiService.put(

                      "categorias/${categoria['id']}",

                      {

                        "nome":
                        nome.text.trim()

                      },

                    );


                  }





                  if(!mounted)
                    return;



                  Navigator.pop(context);


                  carregar();



                  mostrarMensagem(

                      categoria == null

                          ?

                      "Categoria cadastrada"

                          :

                      "Categoria atualizada"

                  );



                }catch(e){



                  mostrarMensagem(
                      e.toString()
                  );


                }




              },

            )



          ],



        );


      },

    );


  }









  Future<void> excluir(
      Map categoria
      ) async {



    bool?
    confirma = await showDialog<bool>(


      context: context,


      builder: (_) {


        return AlertDialog(



          title:
          const Text(
              "Excluir"
          ),



          content:

          Text(
              "Deseja excluir '${categoria['nome']}'?"
          ),




          actions:[



            TextButton(

              child:
              const Text(
                  "Cancelar"
              ),

              onPressed:
                  () => Navigator.pop(
                  context,
                  false
              ),

            ),




            ElevatedButton(

              child:
              const Text(
                  "Excluir"
              ),

              onPressed:
                  () => Navigator.pop(
                  context,
                  true
              ),

            )


          ],



        );


      },

    );




    if(confirma != true)
      return;





    try{


      await ApiService.delete(

          "categorias/${categoria['id']}"

      );



      carregar();



      mostrarMensagem(
          "Categoria excluída"
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
            "Categorias"
        ),

      ),






      floatingActionButton:

      FloatingActionButton.extended(

        onPressed:
            () => abrirCadastro(),

        icon:
        const Icon(Icons.add),

        label:
        const Text(
            "Nova"
        ),

      ),






      body:

      carregando

          ?

      const Center(

        child:
        CircularProgressIndicator(),

      )

          :

      RefreshIndicator(



        onRefresh:
        carregar,



        child:
        Column(



          children:[






            Padding(

              padding:
              const EdgeInsets.all(15),



              child:

              TextField(


                controller:
                pesquisaController,


                onChanged:
                pesquisar,


                decoration:
                InputDecoration(


                  hintText:
                  "Pesquisar categoria...",



                  prefixIcon:
                  const Icon(
                      Icons.search
                  ),



                  border:
                  OutlineInputBorder(

                    borderRadius:
                    BorderRadius.circular(
                        12
                    ),

                  ),

                ),


              ),


            ),







            Expanded(



              child:

              filtro.isEmpty


                  ?


              const Center(

                child:
                Text(
                    "Nenhuma categoria encontrada"
                ),

              )



                  :


              ListView.builder(


                itemCount:
                filtro.length,



                itemBuilder:
                    (_,index){



                  final categoria =
                  filtro[index];



                  return Card(



                    margin:
                    const EdgeInsets.symmetric(

                      horizontal:
                      15,

                      vertical:
                      8,

                    ),





                    child:

                    ListTile(



                      leading:
                      const CircleAvatar(

                        child:
                        Icon(
                            Icons.category
                        ),

                      ),





                      title:

                      Text(

                          categoria['nome']

                      ),





                      trailing:

                      Row(

                        mainAxisSize:
                        MainAxisSize.min,



                        children:[



                          IconButton(

                            icon:
                            const Icon(
                              Icons.edit,
                              color:
                              Colors.blue,
                            ),


                            onPressed:

                                () => abrirCadastro(

                              categoria:
                              categoria,

                            ),

                          ),





                          IconButton(

                            icon:
                            const Icon(

                              Icons.delete,

                              color:
                              Colors.red,

                            ),


                            onPressed:

                                () => excluir(
                                categoria
                            ),


                          )



                        ],


                      ),


                    ),


                  );


                },


              ),


            )



          ],


        ),


      ),


    );


  }


}