import 'package:flutter/material.dart';
import '../services/api_service.dart';



class ClientesFormPage extends StatefulWidget {


  const ClientesFormPage({
    super.key
  });



  @override
  State<ClientesFormPage> createState()
      => _ClientesFormPageState();


}







class _ClientesFormPageState
    extends State<ClientesFormPage>{



  final nome =
      TextEditingController();



  final email =
      TextEditingController();



  final telefone =
      TextEditingController();




  bool salvando = false;







  @override
  void dispose(){

    nome.dispose();

    email.dispose();

    telefone.dispose();

    super.dispose();

  }









  Future<void> salvar() async{



    if(nome.text.trim().isEmpty){


      mostrarMensagem(
          "Informe o nome do cliente"
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
          nome.text.trim(),



          "email":
          email.text.trim(),



          "telefone":
          telefone.text.trim()


        },


      );






      if(!mounted)
        return;




      mostrarMensagem(
          "Cliente cadastrado"
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
            "Novo Cliente"
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






              TextField(

                controller:
                nome,


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
                email,


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
                telefone,


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
                  height:30
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

                    height:
                    20,

                    width:
                    20,

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