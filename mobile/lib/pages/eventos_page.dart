import 'package:flutter/material.dart';
import '../services/api_service.dart';



class EventosPage extends StatefulWidget {

  const EventosPage({
    super.key,
  });


  @override
  State<EventosPage> createState() =>
      _EventosPageState();

}







class _EventosPageState extends State<EventosPage>{


  List eventos = [];

  List clientes = [];

  List servicos = [];

  List categoriasEvento = [];



  bool carregando = true;








  @override
  void initState(){

    super.initState();

    carregar();

  }









  Future<void> carregar() async{


    try{


      final e =
      await ApiService.eventos();


      final c =
      await ApiService.clientes();


      final s =
      await ApiService.servicos();


      final cat =
      await ApiService.categoriasEvento();





      if(!mounted)
        return;




      setState((){


        eventos =
            List.from(e);


        clientes =
            List.from(c);


        servicos =
            List.from(s);


        categoriasEvento =
            List.from(cat);



        carregando =
        false;



      });



    }catch(e){


      setState((){


        carregando = false;


      });



      mostrarMensagem(
          e.toString()
      );


    }



  }












  void novoEvento(){



    final data =
    TextEditingController();


    final hora =
    TextEditingController();


    final local =
    TextEditingController();


    final convidados =
    TextEditingController();


    final obs =
    TextEditingController();



    int? clienteSelecionado;

    int? categoriaSelecionada;



    List<int> servicosSelecionados = [];









    showDialog(



        context: context,


        builder:(context){



          return StatefulBuilder(



              builder:(context,setModalState){



                return AlertDialog(




                  title:

                  const Text(
                      "Novo Evento"
                  ),






                  content:


                  SingleChildScrollView(


                    child:

                    Column(


                      mainAxisSize:

                      MainAxisSize.min,



                      children:[








                        DropdownButtonFormField<int>(



                          decoration:

                          const InputDecoration(

                            labelText:
                            "Cliente",

                          ),





                          value:

                          clienteSelecionado,






                          items:


                          clientes.map<DropdownMenuItem<int>>(

                                  (c){



                                return DropdownMenuItem(



                                  value:

                                  int.parse(
                                      c['id'].toString()
                                  ),



                                  child:

                                  Text(

                                      c['nome'] ?? ""

                                  ),



                                );


                              }

                          ).toList(),






                          onChanged:(v){


                            setModalState((){


                              clienteSelecionado = v;


                            });


                          },


                        ),









                        const SizedBox(
                          height:10,
                        ),







                        DropdownButtonFormField<int>(



                          decoration:

                          const InputDecoration(

                            labelText:
                            "Categoria do evento",

                          ),




                          value:

                          categoriaSelecionada,






                          items:


                          categoriasEvento.map<DropdownMenuItem<int>>(

                                  (c){



                                return DropdownMenuItem(



                                  value:

                                  int.parse(
                                      c['id'].toString()
                                  ),




                                  child:

                                  Text(

                                      c['nome'] ?? ""

                                  ),



                                );


                              }

                          ).toList(),






                          onChanged:(v){



                            setModalState((){


                              categoriaSelecionada = v;



                            });



                          },



                        ),









                        TextField(


                          controller:data,


                          decoration:

                          const InputDecoration(

                            labelText:
                            "Data AAAA-MM-DD",

                          ),


                        ),







                        TextField(


                          controller:hora,


                          decoration:

                          const InputDecoration(

                            labelText:
                            "Hora",

                          ),


                        ),









                        TextField(


                          controller:local,


                          decoration:

                          const InputDecoration(

                            labelText:
                            "Local",

                          ),


                        ),









                        TextField(


                          controller:convidados,


                          keyboardType:

                          TextInputType.number,



                          decoration:

                          const InputDecoration(

                            labelText:
                            "Quantidade convidados",

                          ),


                        ),









                        TextField(


                          controller:obs,


                          maxLines:3,


                          decoration:

                          const InputDecoration(

                            labelText:
                            "Observações",

                          ),


                        ),







                        const SizedBox(
                          height:20,
                        ),







                        const Text(

                          "Serviços",

                          style:

                          TextStyle(

                            fontSize:18,

                            fontWeight:
                            FontWeight.bold,

                          ),

                        ),







                        ...servicos.map((s){



                          final id =

                          int.parse(
                              s['id'].toString()
                          );




                          return CheckboxListTile(



                            title:

                            Text(

                                s['nome'] ?? ""

                            ),





                            subtitle:

                            Text(

                                "R\$ ${s['valor'] ?? 0}"

                            ),




                            value:

                            servicosSelecionados.contains(
                                id
                            ),





                            onChanged:(v){



                              setModalState((){


                                if(v == true){


                                  servicosSelecionados.add(
                                      id
                                  );


                                }else{


                                  servicosSelecionados.remove(
                                      id
                                  );


                                }



                              });



                            },



                          );




                        }).toList(),




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



                      child:

                      const Text(
                          "Salvar"
                      ),





                      onPressed:() async{





                        if(clienteSelecionado == null){


                          mostrarMensagem(
                              "Selecione o cliente"
                          );


                          return;


                        }







                        if(categoriaSelecionada == null){


                          mostrarMensagem(
                              "Selecione a categoria"
                          );


                          return;


                        }







                        try{



                          await ApiService.post(



                              "eventos",



                              {


                                "cliente_id":

                                clienteSelecionado,



                                "categoria_evento_id":

                                categoriaSelecionada,



                                "data":

                                data.text,



                                "hora":

                                hora.text,



                                "local":

                                local.text,



                                "quantidade_convidados":

                                int.tryParse(
                                    convidados.text
                                ) ?? 0,



                                "observacoes":

                                obs.text,



                                "servicos":

                                servicosSelecionados



                              }



                          );






                          Navigator.pop(context);



                          await carregar();




                          mostrarMensagem(

                              "Evento criado"

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



              }



          );


        }



    );


  }













  Future<void> excluir(int id) async{



    try{


      await ApiService.delete(
          "eventos/$id"
      );


      await carregar();



      mostrarMensagem(
          "Evento removido"
      );



    }catch(e){


      mostrarMensagem(
          e.toString()
      );


    }


  }









  String dataFormatada(String? data){



    if(data == null)
      return "";



    try{


      final p =
      data.split("-");


      return "${p[2]}/${p[1]}/${p[0]}";


    }catch(e){


      return data;


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
            "Eventos"
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

        novoEvento,



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

        ListView.builder(



          padding:

          const EdgeInsets.all(15),




          itemCount:

          eventos.length,





          itemBuilder:(context,index){



            final e =

            eventos[index];







            return Card(



              elevation:

              4,



              child:

              ListTile(



                title:

                Text(

                    "${e['categoria']?['nome'] ?? 'Evento'}"

                ),




                subtitle:

                Text(


                    "Cliente: ${e['cliente']?['nome'] ?? ''}\n"

                        "Data: ${dataFormatada(e['data'])}\n"

                        "Local: ${e['local'] ?? ''}"


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

                        int.parse(
                            e['id'].toString()
                        )

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