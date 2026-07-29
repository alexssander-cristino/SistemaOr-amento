import 'package:flutter/material.dart';
import '../services/api_service.dart';


class ServicosPage extends StatefulWidget {

  const ServicosPage({
    super.key,
  });


  @override
  State<ServicosPage> createState() =>
      _ServicosPageState();

}




class _ServicosPageState
    extends State<ServicosPage> {


  List servicos = [];

  List categorias = [];

  List filtro = [];


  bool carregando = true;


  final pesquisa =
      TextEditingController();





  @override
  void initState() {

    super.initState();

    carregar();

  }





  Future<void> carregar() async {


    try {


      final listaServicos =
          await ApiService.servicos();


      final listaCategorias =
          await ApiService.categorias();



      if(!mounted) return;



      setState(() {

        servicos = listaServicos;

        categorias = listaCategorias;

        filtro = listaServicos;

        carregando = false;

      });



    } catch(e) {


      if(!mounted) return;


      setState(() {

        carregando = false;

      });


      mensagem(
          "Erro ao carregar serviços"
      );


    }


  }







  void pesquisar(String texto) {


    if(texto.isEmpty) {


      setState(() {

        filtro = servicos;

      });


      return;

    }





    setState(() {


      filtro = servicos.where((s){


        return s['nome']
            .toString()
            .toLowerCase()
            .contains(
            texto.toLowerCase()
        );


      }).toList();



    });


  }









  void abrirCadastro({Map? servico}) {


    final nome =
    TextEditingController(
      text: servico?['nome'] ?? "",
    );


    final descricao =
    TextEditingController(
      text: servico?['descricao'] ?? "",
    );


    final valor =
    TextEditingController(
      text: servico?['valor']?.toString() ?? "",
    );



    int? categoriaSelecionada =
    servico?['categoria_id'];



    if(categoriaSelecionada == null &&
        servico?['categoria'] != null) {

      categoriaSelecionada =
          servico?['categoria']['id'];

    }






    showDialog(

      context: context,

      builder: (context){


        return StatefulBuilder(

          builder: (context, atualizar){


            return AlertDialog(



              title: Text(

                  servico == null

                      ? "Novo Serviço"

                      : "Editar Serviço"

              ),





              content:

              SingleChildScrollView(

                child:

                Column(

                  children: [



                    TextField(

                      controller: nome,

                      decoration:

                      const InputDecoration(

                        labelText:
                        "Nome",

                      ),

                    ),




                    TextField(

                      controller: descricao,

                      decoration:

                      const InputDecoration(

                        labelText:
                        "Descrição",

                      ),

                    ),





                    TextField(

                      controller: valor,

                      keyboardType:
                      TextInputType.number,

                      decoration:

                      const InputDecoration(

                        labelText:
                        "Valor",

                      ),

                    ),





                    DropdownButtonFormField<int>(


                      value:

                      categorias.any(
                              (c)=>
                          c['id'] ==
                              categoriaSelecionada
                      )

                          ?

                      categoriaSelecionada

                          :

                      null,



                      decoration:

                      const InputDecoration(

                        labelText:
                        "Categoria",

                      ),




                      items:

                      categorias.map((c){


                        return DropdownMenuItem<int>(


                          value:
                          c['id'],


                          child:

                          Text(
                              c['nome'] ?? ""
                          ),


                        );


                      }).toList(),





                      onChanged:(v){


                        atualizar((){

                          categoriaSelecionada = v;


                        });


                      },



                    ),



                  ],

                ),

              ),






              actions: [




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

                  onPressed:() async {



                    if(nome.text.isEmpty ||
                        categoriaSelecionada == null) {


                      mensagem(
                          "Preencha os campos obrigatórios"
                      );


                      return;


                    }




                    final dados = {


                      "nome":
                      nome.text,


                      "descricao":
                      descricao.text,


                      "valor":

                      double.tryParse(

                          valor.text
                              .replaceAll(",", ".")

                      ) ?? 0,



                      "categoria_id":
                      categoriaSelecionada,


                    };





                    bool sucesso = false;



                    try {



                      if(servico == null) {



                        await ApiService.post(

                            "servicos",

                            dados

                        );


                      } else {



                        await ApiService.put(

                            "servicos/${servico['id']}",

                            dados

                        );


                      }



                      sucesso = true;



                    } catch(e) {


                      sucesso = false;


                    }







                    if(sucesso) {


                      Navigator.pop(context);


                      carregar();


                      mensagem(

                          servico == null

                              ?

                          "Serviço cadastrado"

                              :

                          "Serviço atualizado"

                      );


                    } else {


                      mensagem(
                          "Erro ao salvar serviço"
                      );


                    }





                  },



                  child:

                  const Text(
                      "Salvar"
                  ),


                ),



              ],



            );


          },


        );


      },


    );



  }

    Future<void> excluir(Map servico) async {


    bool? confirmar = await showDialog(

      context: context,

      builder: (context){


        return AlertDialog(


          title:

          const Text(
              "Excluir"
          ),



          content:

          Text(
              "Deseja excluir ${servico['nome']}?"
          ),




          actions: [



            TextButton(

              onPressed:(){

                Navigator.pop(
                    context,
                    false
                );

              },

              child:

              const Text(
                  "Cancelar"
              ),

            ),




            ElevatedButton(

              onPressed:(){

                Navigator.pop(
                    context,
                    true
                );

              },

              child:

              const Text(
                  "Excluir"
              ),

            ),



          ],


        );


      },

    );




    if(confirmar != true) return;




    try {



      bool sucesso =

      await ApiService.delete(

          "servicos/${servico['id']}"

      );




      if(sucesso){


        carregar();


        mensagem(
            "Serviço excluído"
        );


      }else{


        mensagem(
            "Erro ao excluir"
        );


      }




    }catch(e){


      mensagem(
          "Erro ao excluir serviço"
      );


    }



  }









  String buscarCategoria(Map servico){


    try {



      if(servico['categoria'] != null &&
          servico['categoria'] is Map){


        return servico['categoria']['nome']
            ?? "";


      }




      final resultado = categorias.where(

              (c)=>

          c['id'] ==
              servico['categoria_id']

      ).toList();





      if(resultado.isEmpty){

        return "";

      }





      return resultado.first['nome']
          ?? "";



    }catch(e){


      return "";


    }



  }







  String dinheiro(dynamic valor){



    double numero =

    double.tryParse(
        valor.toString()
    ) ?? 0;




    return numero

        .toStringAsFixed(2)

        .replaceAll(".", ",");



  }









  void mensagem(String texto){



    if(!mounted) return;



    ScaffoldMessenger.of(context)

        .showSnackBar(



      SnackBar(

        content:

        Text(texto),

      ),


    );


  }







  @override
  void dispose(){


    pesquisa.dispose();


    super.dispose();


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



        onPressed:(){

          abrirCadastro();

        },


        icon:

        const Icon(
            Icons.add
        ),



        label:

        const Text(
            "Novo"
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



      Column(



        children: [





          Padding(


            padding:

            const EdgeInsets.all(15),



            child:

            TextField(



              controller:

              pesquisa,



              onChanged:

              pesquisar,



              decoration:


              InputDecoration(



                hintText:

                "Pesquisar serviço...",



                prefixIcon:

                const Icon(
                    Icons.search
                ),




                border:

                OutlineInputBorder(



                  borderRadius:

                  BorderRadius.circular(12),


                ),



              ),



            ),



          ),







          Expanded(



            child:

            RefreshIndicator(



              onRefresh:

              carregar,



              child:


              filtro.isEmpty



                  ?



              const Center(

                child:

                Text(
                    "Nenhum serviço encontrado"
                ),


              )



                  :



              ListView.builder(



                padding:

                const EdgeInsets.all(15),



                itemCount:

                filtro.length,



                itemBuilder:(context,index){



                  final servico =

                  filtro[index];



                  final categoria =

                  buscarCategoria(
                      servico
                  );






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

                      const CircleAvatar(

                        child:

                        Icon(
                            Icons.work
                        ),

                      ),





                      title:

                      Text(

                        servico['nome']
                            ??
                            "",



                        style:

                        const TextStyle(

                          fontWeight:

                          FontWeight.bold,

                        ),


                      ),





                      subtitle:

                      Column(



                        crossAxisAlignment:

                        CrossAxisAlignment.start,



                        children: [





                          if((servico['descricao']
                              ??
                              "")
                              .toString()
                              .isNotEmpty)



                            Text(

                                servico['descricao']

                            ),






                          Text(

                              "Categoria: $categoria"

                          ),





                          Text(

                            "Valor: R\$ ${dinheiro(servico['valor'])}",



                            style:

                            const TextStyle(

                              fontWeight:

                              FontWeight.bold,


                              color:

                              Colors.green,


                            ),


                          ),



                        ],



                      ),






                      trailing:

                      PopupMenuButton<String>(



                        onSelected:(opcao){



                          if(opcao == "editar"){



                            abrirCadastro(

                                servico:

                                servico

                            );


                          }



                          if(opcao == "excluir"){



                            excluir(
                                servico
                            );


                          }




                        },






                        itemBuilder:(context)=>[



                          const PopupMenuItem(



                            value:

                            "editar",



                            child:

                            Row(

                              children: [


                                Icon(
                                    Icons.edit
                                ),



                                SizedBox(
                                    width:8
                                ),



                                Text(
                                    "Editar"
                                ),


                              ],


                            ),



                          ),





                          const PopupMenuItem(



                            value:

                            "excluir",



                            child:

                            Row(

                              children: [



                                Icon(

                                  Icons.delete,

                                  color:

                                  Colors.red,

                                ),




                                SizedBox(
                                    width:8
                                ),




                                Text(
                                    "Excluir"
                                ),


                              ],


                            ),



                          ),



                        ],



                      ),



                    ),



                  );



                },



              ),



            ),



          ),



        ],



      ),



    );


  }


}