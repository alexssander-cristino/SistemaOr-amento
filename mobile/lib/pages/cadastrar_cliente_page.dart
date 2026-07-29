import 'package:flutter/material.dart';
import '../services/api_service.dart';


class CadastrarClientePage extends StatefulWidget {


  const CadastrarClientePage({
    super.key
  });



  @override
  State<CadastrarClientePage> createState()
      => _CadastrarClientePageState();

}





class _CadastrarClientePageState
    extends State<CadastrarClientePage> {



  final nomeController =
      TextEditingController();


  final emailController =
      TextEditingController();


  final telefoneController =
      TextEditingController();



  bool salvando = false;







  @override
  void dispose(){

    nomeController.dispose();

    emailController.dispose();

    telefoneController.dispose();

    super.dispose();

  }









  Future<void> salvar() async {



    if(nomeController.text.trim().isEmpty){


      mostrarMensagem(
          "Informe o nome"
      );


      return;

    }





    setState((){

      salvando = true;

    });





    try{



      await ApiService.post(

        "clientes",

        {


          "nome":
          nomeController.text.trim(),



          "email":
          emailController.text.trim(),



          "telefone":
          telefoneController.text.trim()


        },


      );




      if(!mounted)
        return;



      mostrarMensagem(
          "Cliente cadastrado com sucesso"
      );



      Navigator.pop(context);



    }catch(e){



      mostrarMensagem(

          "Erro ao cadastrar cliente\n$e"

      );



    }finally{



      if(mounted){


        setState((){

          salvando = false;

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









  @override
  Widget build(BuildContext context){



    return Scaffold(



      appBar:
      AppBar(

        title:
        const Text(
            "Cadastrar Cliente"
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


            children: [






              TextField(

                controller:
                nomeController,


                decoration:
                const InputDecoration(

                  labelText:
                  "Nome",

                  border:
                  OutlineInputBorder(),

                ),

              ),






              const SizedBox(
                  height:15
              ),






              TextField(

                controller:
                emailController,


                keyboardType:
                TextInputType.emailAddress,


                decoration:
                const InputDecoration(

                  labelText:
                  "Email",

                  border:
                  OutlineInputBorder(),

                ),

              ),






              const SizedBox(
                  height:15
              ),






              TextField(

                controller:
                telefoneController,


                keyboardType:
                TextInputType.phone,


                decoration:
                const InputDecoration(

                  labelText:
                  "Telefone",

                  border:
                  OutlineInputBorder(),

                ),

              ),






              const SizedBox(
                  height:25
              ),






              SizedBox(


                width:
                double.infinity,



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

                    height:20,

                    width:20,

                    child:
                    CircularProgressIndicator(),

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