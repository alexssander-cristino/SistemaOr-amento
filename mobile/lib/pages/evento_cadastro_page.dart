import 'package:flutter/material.dart';
import '../services/api_service.dart';



class EventoCadastroPage extends StatefulWidget {


  const EventoCadastroPage({
    super.key
  });



  @override
  State<EventoCadastroPage> createState()
      => _EventoCadastroPageState();


}








class _EventoCadastroPageState
    extends State<EventoCadastroPage>{



  final tipoController =
      TextEditingController();



  final dataController =
      TextEditingController();



  final horaController =
      TextEditingController();



  final localController =
      TextEditingController();



  final convidadosController =
      TextEditingController();



  final observacoesController =
      TextEditingController();




  bool salvando = false;









  @override
  void dispose(){


    tipoController.dispose();

    dataController.dispose();

    horaController.dispose();

    localController.dispose();

    convidadosController.dispose();

    observacoesController.dispose();


    super.dispose();


  }









  Future<void> salvar() async{





    if(tipoController.text.trim().isEmpty ||
       dataController.text.trim().isEmpty){



      mostrarMensagem(
          "Preencha os campos obrigatórios"
      );


      return;


    }







    setState((){


      salvando = true;


    });







    try{





      await ApiService.post(



        "eventos",




        {



          "tipo":

          tipoController.text.trim(),





          "data":

          dataController.text.trim(),





          "hora":

          horaController.text.trim(),





          "local":

          localController.text.trim(),





          "quantidade_convidados":

          int.tryParse(

              convidadosController.text

          ) ?? 0,





          "observacoes":

          observacoesController.text.trim(),



        },



      );







      if(!mounted)
        return;







      mostrarMensagem(

          "Evento cadastrado com sucesso"

      );





      Navigator.pop(context);






    }catch(e){





      mostrarMensagem(

          "Erro ao cadastrar evento\n$e"

      );





    }finally{



      if(mounted){



        setState((){


          salvando=false;


        });



      }


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









  Widget campo(

      TextEditingController controller,

      String texto,

      IconData icone

      ){



    return Padding(



      padding:

      const EdgeInsets.only(

          bottom:15

      ),



      child:

      TextField(



        controller:

        controller,



        decoration:

        InputDecoration(



          labelText:

          texto,



          prefixIcon:

          Icon(icone),



          border:

          const OutlineInputBorder(),



        ),



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

            "Novo Evento"

        ),



      ),







      body:

      SingleChildScrollView(



        padding:

        const EdgeInsets.all(20),




        child:

        Column(



          children:[





            campo(

              tipoController,

              "Tipo do evento",

              Icons.event,

            ),






            campo(

              dataController,

              "Data (AAAA-MM-DD)",

              Icons.calendar_today,

            ),






            campo(

              horaController,

              "Horário",

              Icons.access_time,

            ),






            campo(

              localController,

              "Local",

              Icons.location_on,

            ),






            campo(

              convidadosController,

              "Quantidade convidados",

              Icons.people,

            ),






            campo(

              observacoesController,

              "Observações",

              Icons.description,

            ),






            const SizedBox(

                height:20

            ),







            SizedBox(



              width:

              double.infinity,



              height:

              50,




              child:

              ElevatedButton(



                onPressed:

                salvando

                    ?

                null

                    :

                salvar,




                child:

                salvando



                    ?


                const SizedBox(


                  height:25,


                  width:25,


                  child:

                  CircularProgressIndicator(

                    color:
                    Colors.white,

                  ),


                )



                    :



                const Text(

                    "Salvar Evento"

                ),



              ),



            )





          ],



        ),



      ),



    );



  }



}