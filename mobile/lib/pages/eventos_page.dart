import 'package:flutter/material.dart';
import '../services/api_service.dart';


class EventosPage extends StatefulWidget {

  const EventosPage({
    super.key,
  });


  @override
  State<EventosPage> createState() => _EventosPageState();

}




class _EventosPageState extends State<EventosPage> {


  List eventos = [];
  List clientes = [];
  List servicos = [];
  List categoriasEvento = [];


  bool carregando = true;




  @override
  void initState() {

    super.initState();

    carregar();

  }






  Future<void> carregar() async {


    try {


      final e = await ApiService.eventos();

      final c = await ApiService.clientes();

      final s = await ApiService.servicos();

      final cat = await ApiService.categoriasEvento();



      if(!mounted) return;



      setState(() {


        eventos = List.from(e);

        clientes = List.from(c);

        servicos = List.from(s);

        categoriasEvento = List.from(cat);


        carregando = false;


      });



    } catch(e) {


      setState(() {

        carregando = false;

      });


      mensagem(
        e.toString(),
      );


    }


  }







  void novoEvento() {


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



    Map<int,int> servicosSelecionados = {};




    showDialog(


      context: context,


      builder: (context) {


        return StatefulBuilder(


          builder: (context,setModalState) {



            double total = 0;



            for(var item in servicosSelecionados.entries){



              final servico =
              servicos.firstWhere(
                    (s)=>
                int.parse(
                    s["id"].toString()
                )
                ==
                item.key,
              );



              final valor =
                  double.tryParse(
                    servico["valor"].toString(),
                  )
                      ??
                      0;



              total += valor * item.value;


            }






            return AlertDialog(


              title:
              const Text(
                  "Novo Evento"
              ),



              content:


              SizedBox(


                width:500,


                child:


                SingleChildScrollView(


                  child:


                  Column(


                    children: [



                      DropdownButtonFormField<int>(


                        decoration:
                        const InputDecoration(

                          labelText:
                          "Cliente",

                        ),



                        value:
                        clienteSelecionado,



                        items:
                        clientes.map(
                                (c){


                              return DropdownMenuItem<int>(


                                value:
                                int.parse(
                                  c["id"]
                                      .toString(),
                                ),



                                child:
                                Text(
                                  c["nome"] ?? "",
                                ),


                              );


                            }
                        ).toList(),



                        onChanged:
                            (v){


                          setModalState((){


                            clienteSelecionado =
                                v;


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
                          "Categoria do Evento",

                        ),



                        value:
                        categoriaSelecionada,



                        items:
                        categoriasEvento.map(
                                (c){


                              return DropdownMenuItem<int>(


                                value:
                                int.parse(
                                  c["id"]
                                      .toString(),
                                ),



                                child:
                                Text(
                                  c["nome"] ?? "",
                                ),


                              );


                            }
                        ).toList(),



                        onChanged:
                            (v){


                          setModalState((){


                            categoriaSelecionada =
                                v;


                          });


                        },


                      ),





                      const SizedBox(
                        height:10,
                      ),



                      TextField(

                        controller:data,

                        decoration:
                        const InputDecoration(

                          labelText:
                          "Data",

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


                      const Divider(),


                      const Text(
                        "Serviços",
                        style:
                        TextStyle(
                          fontSize:18,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),


                      const SizedBox(
                        height:10,
                      ),



                      ...servicos.map((s){

  final id = int.parse(
    s["id"].toString(),
  );


  final valor = double.tryParse(
    s["valor"].toString(),
  ) ?? 0;


  final selecionado =
      servicosSelecionados.containsKey(id);



  return Card(

    child: Padding(

      padding:
      const EdgeInsets.all(10),


      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,


        children: [


          CheckboxListTile(

            contentPadding:
            EdgeInsets.zero,


            value:
            selecionado,


            title:
            Text(
              s["nome"] ?? "",
              style:
              const TextStyle(
                fontWeight:
                FontWeight.bold,
              ),
            ),


            subtitle:
            Text(
              "Valor unitário: R\$ ${valor.toStringAsFixed(2)}",
            ),


            onChanged:(v){


              setModalState((){


                if(v == true){


                  servicosSelecionados[id] = 1;


                }else{


                  servicosSelecionados.remove(id);


                }


              });


            },


          ),





          if(selecionado)


          Row(

            children: [


              const Text(
                "Quantidade:"
              ),


              const SizedBox(
                width:10,
              ),




              SizedBox(

                width:70,


                child:


                TextFormField(


                  initialValue:
                  servicosSelecionados[id]
                      .toString(),



                  keyboardType:
                  TextInputType.number,



                  decoration:
                  const InputDecoration(

                    border:
                    OutlineInputBorder(),

                  ),



                  onChanged:(v){


                    setModalState((){


                      servicosSelecionados[id] =
                          int.tryParse(v) ?? 1;


                    });


                  },


                ),

              ),




              const Spacer(),




              Text(

                "Subtotal: R\$ ${
                    (
                        valor *
                        (servicosSelecionados[id] ?? 1)
                    )
                        .toStringAsFixed(2)
                }",


                style:
                const TextStyle(

                  fontWeight:
                  FontWeight.bold,

                ),


              ),



            ],


          ),



        ],


      ),


    ),


  );


}).toList(),





                      const SizedBox(
                        height:20,
                      ),





                      const Divider(),





                      Row(


                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,



                        children: [



                          const Text(

                            "Valor Total",

                            style:
                            TextStyle(

                              fontSize:18,

                              fontWeight:
                              FontWeight.bold,

                            ),

                          ),




                          Text(


                            "R\$ ${total.toStringAsFixed(2)}",


                            style:
                            const TextStyle(

                              fontSize:20,

                              color:
                              Colors.green,

                              fontWeight:
                              FontWeight.bold,

                            ),


                          ),



                        ],


                      ),



                    ],


                  ),


                ),


              ),



              actions: [



                TextButton(


                  onPressed:
                      (){


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



                  onPressed:
                      () async {



                    if(clienteSelecionado == null){


                      mensagem(
                          "Selecione o cliente"
                      );

                      return;


                    }





                    if(categoriaSelecionada == null){


                      mensagem(
                          "Selecione a categoria"
                      );

                      return;


                    }





                    if(servicosSelecionados.isEmpty){


                      mensagem(
                          "Selecione um serviço"
                      );

                      return;


                    }



                    try {



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
                          )
                              ??
                              0,



                          "observacoes":
                          obs.text,



                          "servicos":
                          servicosSelecionados.entries
                              .map(
                                  (e)=>{


                                "servico_id":
                                e.key,


                                "quantidade":
                                e.value,


                              }
                          )
                              .toList(),


                        },


                      );




                      Navigator.pop(context);



                      await carregar();



                      mensagem(
                          "Evento criado com sucesso"
                      );



                    }catch(e){



                      mensagem(
                          e.toString()
                      );


                    }



                  },


                ),



              ],



            );


          },


        );


      },


    );


  }
  Future<void> excluir(int id) async {


    try {


      await ApiService.delete(
        "eventos/$id",
      );


      await carregar();



      mensagem(
        "Evento removido",
      );



    } catch(e){


      mensagem(
        e.toString(),
      );


    }


  }







  String dataFormatada(String? data){


    if(data == null){
      return "";
    }



    try{


      final partes =
      data.split("-");



      return
        "${partes[2]}/${partes[1]}/${partes[0]}";



    }catch(_){


      return data;


    }


  }








  void mensagem(String texto){


    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        content:
        Text(texto),

      ),

    );


  }









  @override
  Widget build(BuildContext context) {


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



        onPressed:
        novoEvento,



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



      RefreshIndicator(



        onRefresh:
        carregar,



        child:



        ListView.builder(



          padding:
          const EdgeInsets.all(
              15
          ),



          itemCount:
          eventos.length,



          itemBuilder:
              (context,index){



            final evento =
            eventos[index];






            return Card(



              elevation:
              4,



              margin:
              const EdgeInsets.only(
                bottom:10,
              ),




              child:
              ListTile(



                title:
                Text(



                  evento["categoria"]?["nome"]
                      ??
                      "Evento",



                  style:
                  const TextStyle(

                    fontWeight:
                    FontWeight.bold,

                  ),



                ),





                subtitle:
                Text(



                  "Cliente: "
                      "${evento["cliente"]?["nome"] ?? ""}\n"

                      "Data: "
                      "${dataFormatada(
                      evento["data"]
                  )}\n"

                      "Hora: "
                      "${evento["hora"] ?? ""}\n"

                      "Local: "
                      "${evento["local"] ?? ""}",



                ),






                trailing:



                IconButton(



                  icon:
                  const Icon(

                    Icons.delete,

                    color:
                    Colors.red,

                  ),




                  onPressed:
                      (){



                    excluir(

                      int.parse(

                        evento["id"]
                            .toString(),

                      ),

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