import 'package:flutter/material.dart';
import '../services/api_service.dart';



class EventosFormPage extends StatefulWidget{


  const EventosFormPage({
    super.key
  });



  @override
  State<EventosFormPage> createState()
      => _EventosFormPageState();



}







class _EventosFormPageState
    extends State<EventosFormPage>{



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




  bool salvando = false;









  @override
  void dispose(){


    tipo.dispose();

    data.dispose();

    hora.dispose();

    local.dispose();

    convidados.dispose();


    super.dispose();


  }









  Future<void> salvar() async{



    if(tipo.text.trim().isEmpty ||
        data.text.trim().isEmpty){



      mostrarMensagem(
          "Preencha tipo e data do evento"
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

          tipo.text.trim(),




          "data":

          data.text.trim(),




          "hora":

          hora.text.trim(),




          "local":

          local.text.trim(),




          "quantidade_convidados":

          int.tryParse(

              convidados.text

          ) ?? 0



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

      String label,

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
          label,



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

      Padding(



        padding:
        const EdgeInsets.all(20),



        child:

        SingleChildScrollView(



          child:

          Column(



            children:[





              campo(

                  tipo,

                  "Tipo do evento"

              ),






              campo(

                  data,

                  "Data (AAAA-MM-DD)"

              ),






              campo(

                  hora,

                  "Hora"

              ),






              campo(

                  local,

                  "Local"

              ),






              TextField(



                controller:
                convidados,



                keyboardType:
                TextInputType.number,



                decoration:

                const InputDecoration(


                  labelText:
                  "Quantidade convidados",


                  border:
                  OutlineInputBorder(),


                ),



              ),






              const SizedBox(

                  height:30

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

                    height:22,

                    width:22,

                    child:

                    CircularProgressIndicator(

                      color:
                      Colors.white,

                    ),

                  )



                      :


                  const Text(

                      "Salvar"

                  ),



                ),


              )






            ],


          ),



        ),



      ),



    );



  }



}