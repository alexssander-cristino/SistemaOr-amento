import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../services/pdf_service.dart';



class OrcamentosPage extends StatefulWidget {

  const OrcamentosPage({
    super.key,
  });


  @override
  State<OrcamentosPage> createState() =>
      _OrcamentosPageState();

}





class _OrcamentosPageState extends State<OrcamentosPage> {


  List eventos = [];

  List orcamentos = [];

  bool carregando = true;





  @override
  void initState() {

    super.initState();

    carregar();

  }







  Future<void> carregar() async {


    try {


      final e =
      await ApiService.eventos();



      final o =
      await ApiService.orcamentos();




      if(!mounted) return;



      setState(() {


        eventos =
            List.from(e);


        orcamentos =
            List.from(o);


        carregando =
        false;


      });



    }catch(e){


      setState(() {

        carregando=false;

      });



      mensagem(
          e.toString()
      );


    }


  }









  String nomeEvento(dynamic evento){


    if(evento == null){

      return "Evento";

    }



    final categoria =
        evento['categoria']?['nome']
            ??
            evento['tipo']
            ??
            "Evento";



    final cliente =
        evento['cliente']?['nome']
            ??
            "Cliente";



    final data =
        evento['data']
            ??
            "";



    return
      "$categoria - $cliente - $data";


  }









  void novoOrcamento(){


    int? eventoId;



    showDialog(

      context: context,


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



                decoration:
                const InputDecoration(

                  labelText:
                  "Evento",

                  border:
                  OutlineInputBorder(),

                ),




                value:eventoId,




                items:

                eventos.map((e){



                  return DropdownMenuItem<int>(


                    value:
                    int.parse(
                        e['id'].toString()
                    ),



                    child:
                    Text(
                        nomeEvento(e)
                    ),


                  );


                }).toList(),




                onChanged:(v){


                  setModal((){

                    eventoId=v;

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

                  child:
                  const Text(
                      "Criar"
                  ),




                  onPressed:() async{


                    if(eventoId==null){


                      mensagem(
                          "Selecione um evento"
                      );


                      return;


                    }




                    try{


                      await ApiService.post(

                        "orcamentos",

                        {

                          "evento_id":
                          eventoId,


                          "desconto":
                          0,


                          "status":
                          "pendente"


                        },


                      );



                      Navigator.pop(context);



                      await carregar();



                      mensagem(
                          "Orçamento criado"
                      );



                    }catch(e){


                      mensagem(
                          e.toString()
                      );


                    }



                  },



                )



              ],


            );


          },


        );


      },


    );



  }









  void gerarPdf(dynamic orc){


    List itens=[];




    if(orc['itens'] != null){


      itens =
      List.from(
          orc['itens']
      );


    }





    if(itens.isEmpty){


      itens =
      List.from(
          orc['evento']?['servicos'] ?? []
      );


    }





    double total=0;




    for(var item in itens){



      double valor=0;

      int quantidade=1;



      if(item['servico'] != null){



        valor =
            double.tryParse(

                (

                    item['valor_unitario']

                        ??

                    item['servico']['valor']

                        ??

                    0

                ).toString()

            )
                ??
                0;



        quantidade =
            int.tryParse(

                (

                    item['quantidade']

                        ??

                    1

                ).toString()

            )
                ??
                1;



      }



      else{


        valor =
            double.tryParse(

                (

                    item['valor']

                        ??

                    item['pivot']?['valor_unitario']

                        ??

                    0

                ).toString()

            )
                ??
                0;




        quantidade =
            int.tryParse(

                (

                    item['pivot']?['quantidade']

                        ??

                    item['quantidade']

                        ??

                    1

                ).toString()

            )
                ??
                1;


      }





      item['quantidade_pdf']=quantidade;


      item['subtotal_pdf']=

          valor * quantidade;



      total +=

          valor * quantidade;



    }





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

      itens,




      total:

      total,



    );


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
            "Orçamentos"
        ),

      ),




      floatingActionButton:


      FloatingActionButton.extended(

        onPressed:
        novoOrcamento,


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
          const EdgeInsets.all(15),




          itemCount:
          orcamentos.length,





          itemBuilder:(context,index){



            final o =
            orcamentos[index];




            return Card(



              child:
              ListTile(



                title:
                Text(

                  "Orçamento #${o['id']}",

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