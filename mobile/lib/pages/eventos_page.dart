import 'package:flutter/material.dart';
import '../services/api_service.dart';



class EventosPage extends StatefulWidget {


  const EventosPage({
    super.key
  });



  @override
  State<EventosPage> createState()
      => _EventosPageState();


}








class _EventosPageState
    extends State<EventosPage>{



  List eventos = [];

  List clientes = [];

  List servicos = [];



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





      if(!mounted)
        return;



      setState((){


        eventos = e;

        clientes = c;

        servicos = s;

        carregando = false;


      });



    }catch(e){



      setState((){

        carregando = false;

      });



      mostrarMensagem(
          "Erro ao carregar dados"
      );


    }



  }









  void novoEvento(){



    final tipo =
    TextEditingController();



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



    List<int> servicosSelecionados = [];







    showDialog(


      context: context,


      builder:(context){



        return StatefulBuilder(



          builder:(context,setModalState){



            double total = 0;



            for(var s in servicos){


              if(servicosSelecionados.contains(
                  s['id']
              )){


                total += double.tryParse(

                    s['valor'].toString()

                ) ?? 0;


              }


            }







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

                        prefixIcon:
                        Icon(
                            Icons.person
                        ),

                      ),




                      value:

                      clienteSelecionado,





                      items:

                      clientes.map<DropdownMenuItem<int>>(
                              (c){



                            return DropdownMenuItem(


                              value:
                              c['id'],



                              child:

                              Text(

                                  c['nome'] ?? ""

                              ),


                            );



                          }).toList(),






                      onChanged:(v){



                        setModalState((){


                          clienteSelecionado = v;


                        });



                      },



                    ),







                    TextField(


                      controller:

                      tipo,


                      decoration:

                      const InputDecoration(

                        labelText:
                        "Tipo do evento"

                      )


                    ),








                    TextField(


                      controller:

                      data,


                      decoration:

                      const InputDecoration(

                        labelText:
                        "Data AAAA-MM-DD"

                      )


                    ),







                    TextField(


                      controller:

                      hora,


                      decoration:

                      const InputDecoration(

                        labelText:
                        "Hora"

                      )


                    ),








                    TextField(


                      controller:

                      local,


                      decoration:

                      const InputDecoration(

                        labelText:
                        "Local"

                      )


                    ),







                    TextField(


                      controller:

                      convidados,


                      keyboardType:

                      TextInputType.number,



                      decoration:

                      const InputDecoration(

                        labelText:
                        "Convidados"

                      )


                    ),







                    TextField(


                      controller:

                      obs,


                      maxLines:

                      3,



                      decoration:

                      const InputDecoration(

                        labelText:
                        "Observações"

                      )


                    ),







                    const SizedBox(
                        height:20
                    ),








                    const Text(

                      "Serviços",

                      style:

                      TextStyle(

                        fontSize:
                        18,

                        fontWeight:
                        FontWeight.bold,

                      ),

                    ),







                    ...servicos.map((s){



                      return CheckboxListTile(



                        title:

                        Text(

                            s['nome'] ?? ""

                        ),




                        subtitle:

                        Text(

                            "R\$ ${s['valor']}"

                        ),





                        value:

                        servicosSelecionados.contains(
                            s['id']
                        ),






                        onChanged:(valor){



                          setModalState((){



                            if(valor == true){


                              servicosSelecionados.add(
                                  s['id']
                              );



                            }else{


                              servicosSelecionados.remove(
                                  s['id']
                              );


                            }



                          });



                        },



                      );



                    }),







                    Text(

                      "Total serviços: R\$ ${total.toStringAsFixed(2)}",


                      style:

                      const TextStyle(

                        fontWeight:
                        FontWeight.bold,

                        fontSize:
                        18,

                      ),


                    )




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



                    if(clienteSelecionado == null){


                      mostrarMensagem(
                          "Selecione um cliente"
                      );


                      return;


                    }







                    try{



                      await ApiService.post(



                        "eventos",



                        {


                          "cliente_id":

                          clienteSelecionado,



                          "tipo":

                          tipo.text,



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



                        },


                      );






                      if(!mounted)
                        return;





                      Navigator.pop(context);



                      carregar();





                      mostrarMensagem(

                          "Evento criado"

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
                  )



                )






              ]




            );



          }


        );



      }


    ).then((_){


      tipo.dispose();

      data.dispose();

      hora.dispose();

      local.dispose();

      convidados.dispose();

      obs.dispose();


    });



  }









  Future<void> excluir(int id) async{



    try{



      await ApiService.delete(

          "eventos/$id"

      );



      carregar();



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


      var p =
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



                leading:

                const CircleAvatar(

                  child:

                  Icon(
                      Icons.event
                  ),

                ),







                title:

                Text(

                    e['tipo'] ?? ""

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

                    Colors.red,

                  ),




                  onPressed:(){


                    excluir(
                        e['id']
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