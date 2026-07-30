import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../services/pdf_service.dart';



class OrcamentosPage extends StatefulWidget {


  const OrcamentosPage({
    super.key
  });



  @override
  State<OrcamentosPage> createState()
      => _OrcamentosPageState();

}







class _OrcamentosPageState extends State<OrcamentosPage>{



  List eventos = [];

  List orcamentos = [];

  bool carregando = true;








  @override
  void initState(){

    super.initState();

    carregar();

  }









  Future<void> carregar() async{


    try{


      final eventosApi =
      await ApiService.eventos();



      final orcamentosApi =
      await ApiService.orcamentos();





      print("ORCAMENTOS API");

      print(orcamentosApi);






      if(!mounted)return;





      setState((){


        eventos = eventosApi;

        orcamentos = orcamentosApi;

        carregando = false;


      });





    }catch(e){


      print(e);



      setState((){

        carregando=false;

      });



      mostrarMensagem(
          "Erro ao carregar orçamentos"
      );



    }


  }












  String nomeEvento(var evento){



    if(evento == null){

      return "Evento";

    }





    String categoria =

    evento['categoria']?['nome']

        ??

    evento['tipo']

        ??

    "Evento";







    String cliente =

    evento['cliente']?['nome']

        ??

    "Cliente";







    String data =

    evento['data']

        ??

    "";







    return "$categoria - $cliente - $data";

  }












  void novoOrcamento(){



    int? eventoSelecionado;






    showDialog(



      context:context,



      builder:(context){





        return StatefulBuilder(





          builder:(context,setModal){





            return AlertDialog(



              title:

              const Text(
                  "Novo Orçamento"
              ),






              content:



              DropdownButtonFormField<int>(



                value:eventoSelecionado,





                decoration:

                const InputDecoration(


                  labelText:
                  "Selecione o evento",


                  border:
                  OutlineInputBorder(),

                ),






                items:



                eventos.map<DropdownMenuItem<int>>(

                        (e){





                      return DropdownMenuItem<int>(



                        value:

                        e['id'],





                        child:

                        Text(

                            nomeEvento(e)

                        ),



                      );





                    }

                ).toList(),







                onChanged:(v){



                  setModal((){

                    eventoSelecionado = v;


                  });



                },



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



                    if(eventoSelecionado == null){



                      mostrarMensagem(

                          "Selecione um evento"

                      );


                      return;

                    }









                    try{





                      await ApiService.post(



                          "orcamentos",



                          {


                            "evento_id":

                            eventoSelecionado,



                            "desconto":

                            0,



                            "valor_total":

                            0,



                            "status":

                            "pendente"



                          }



                      );







                      Navigator.pop(context);



                      carregar();





                      mostrarMensagem(

                          "Orçamento criado"

                      );





                    }catch(e){



                      mostrarMensagem(

                          e.toString()

                      );


                    }



                  },




                  child:

                  const Text(
                      "Criar"
                  )



                )





              ],





            );



          },



        );



      },



    );


  }













  void gerarPdf(var orc){


  List servicos = [];



  // Primeiro tenta pegar itens do orçamento
  if(orc['itens'] != null){

    servicos = List.from(
      orc['itens']
    );

  }





  // Caso venha pelos serviços do evento
  if(servicos.isEmpty &&
      orc['evento'] != null &&
      orc['evento']['servicos'] != null){


    servicos = List.from(
        orc['evento']['servicos']
    );


  }





  double total = 0;




  for(var item in servicos){


    double valor = 0;

    int quantidade = 1;

    double subtotal = 0;





    // Quando vem de orcamento_servicos
    if(item['servico'] != null){


      valor = double.tryParse(

          (

              item['valor_unitario']

                  ??

              item['servico']['valor']

                  ??

              0

          ).toString()

      ) ?? 0;




      quantidade = int.tryParse(

          (

              item['quantidade']

                  ??

              1

          ).toString()

      ) ?? 1;




      subtotal = double.tryParse(

          (

              item['subtotal']

                  ??

              valor * quantidade

          ).toString()

      ) ?? 0;



    }





    // Quando vem do evento_servicos
    else {


      valor = double.tryParse(

          (

              item['pivot']?['valor_unitario']

                  ??

              item['valor']

                  ??

              0

          ).toString()

      ) ?? 0;





      quantidade = int.tryParse(

          (

              item['pivot']?['quantidade']

                  ??

              1

          ).toString()

      ) ?? 1;





      subtotal = double.tryParse(

          (

              item['pivot']?['subtotal']

                  ??

              valor * quantidade

          ).toString()

      ) ?? 0;



    }






    total += subtotal;



  }







  print("SERVICOS PDF:");
  print(servicos);


  print("TOTAL PDF:");
  print(total);






  PdfService.gerarOrcamento(


      cliente:

      orc['evento']?['cliente']?['nome']

          ??

          "Cliente",





      evento:

      nomeEvento(

          orc['evento']

      ),





      servicos:

      servicos,





      total:

      total



  );



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

            "Orçamentos"

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

        novoOrcamento,



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

          orcamentos.length,





          itemBuilder:(context,index){



            final o =

            orcamentos[index];







            return Card(



              elevation:4,





              child:

              ListTile(



                title:

                Text(

                    "Orçamento #${o['id']}"

                ),






                subtitle:

                Text(


                    "Cliente: "

                        "${o['evento']?['cliente']?['nome'] ?? ''}\n"



                        "Evento: "

                        "${nomeEvento(o['evento'])}\n"



                        "Status: "

                        "${o['status'] ?? ''}"



                ),






                trailing:

                IconButton(



                  icon:

                  const Icon(

                      Icons.picture_as_pdf

                  ),




                  onPressed:(){


                    gerarPdf(o);


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