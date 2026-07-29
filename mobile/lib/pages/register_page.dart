import 'package:flutter/material.dart';
import '../services/api_service.dart';


class RegisterPage extends StatefulWidget {


  const RegisterPage({
    super.key
  });



  @override
  State<RegisterPage> createState() =>
      _RegisterPageState();


}






class _RegisterPageState
extends State<RegisterPage>{



  final nome =
  TextEditingController();



  final email =
  TextEditingController();



  final senha =
  TextEditingController();




  bool carregando = false;



  bool esconderSenha = true;








  @override
  void dispose(){


    nome.dispose();

    email.dispose();

    senha.dispose();


    super.dispose();


  }









  bool validarEmail(String valor){


    return RegExp(

      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'

    ).hasMatch(valor);


  }









  Future<void> cadastrar() async{



    if(carregando)
      return;





    if(nome.text.trim().isEmpty ||
        email.text.trim().isEmpty ||
        senha.text.trim().isEmpty){



      mensagem(
          "Preencha todos os campos"
      );


      return;


    }







    if(!validarEmail(email.text)){



      mensagem(
          "Digite um email válido"
      );


      return;


    }







    if(senha.text.length < 6){



      mensagem(
          "A senha deve ter no mínimo 6 caracteres"
      );


      return;


    }







    setState((){


      carregando = true;


    });






    try{



      bool sucesso =

      await ApiService.register(

          nome.text.trim(),

          email.text.trim(),

          senha.text.trim()

      );







      if(sucesso){



        mensagem(
            "Usuário cadastrado com sucesso!"
        );



        await Future.delayed(

            const Duration(
                milliseconds:500
            )

        );




        if(!mounted)
          return;



        Navigator.pushReplacementNamed(

            context,

            "/login"

        );





      }else{



        mensagem(

            "Erro ao cadastrar usuário"

        );


      }






    }catch(e){



      mensagem(

          "Erro de conexão"

      );



      print(e);




    }finally{



      if(mounted){


        setState((){


          carregando=false;


        });


      }



    }





  }









  void mensagem(String texto){



    if(!mounted)
      return;




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



      backgroundColor:

      Colors.grey[100],







      body:

      Center(




        child:

        SingleChildScrollView(




          child:

          Container(




            width:

            360,





            padding:

            const EdgeInsets.all(25),





            decoration:

            BoxDecoration(



              color:

              Colors.white,



              borderRadius:

              BorderRadius.circular(15),





              boxShadow:[



                BoxShadow(



                  color:

                  Colors.black12,



                  blurRadius:

                  10,



                )



              ]



            ),








            child:

            Column(



              mainAxisSize:

              MainAxisSize.min,





              children:[






                const Text(



                  "Criar Usuário",





                  style:

                  TextStyle(



                    fontSize:

                    26,



                    fontWeight:

                    FontWeight.bold,



                  ),



                ),







                const SizedBox(
                    height:25
                ),








                TextField(



                  controller:

                  nome,



                  decoration:

                  campo(

                      "Nome",

                      Icons.person

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

                  campo(

                      "Email",

                      Icons.email

                  ),



                ),







                const SizedBox(
                    height:15
                ),








                TextField(



                  controller:

                  senha,



                  obscureText:

                  esconderSenha,




                  decoration:

                  campo(

                      "Senha",

                      Icons.lock

                  ).copyWith(



                    suffixIcon:

                    IconButton(



                      icon:

                      Icon(



                        esconderSenha

                            ?

                        Icons.visibility

                            :

                        Icons.visibility_off



                      ),




                      onPressed:(){


                        setState((){


                          esconderSenha =
                          !esconderSenha;



                        });


                      },


                    ),



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

                    carregando

                        ?

                    null

                        :

                    cadastrar,







                    style:

                    ElevatedButton.styleFrom(



                      padding:

                      const EdgeInsets.all(15),



                      backgroundColor:

                      Colors.blue,




                      shape:

                      RoundedRectangleBorder(



                        borderRadius:

                        BorderRadius.circular(10),



                      ),



                    ),







                    child:

                    carregando



                        ?



                    const SizedBox(



                      height:

                      22,



                      width:

                      22,



                      child:

                      CircularProgressIndicator(



                        color:

                        Colors.white,



                        strokeWidth:

                        2,



                      ),



                    )





                        :



                    const Text(



                      "Cadastrar",




                      style:

                      TextStyle(



                        color:

                        Colors.white,



                        fontSize:

                        16,



                      ),



                    ),



                  ),



                ),







                TextButton(



                  onPressed:(){



                    Navigator.pushReplacementNamed(

                        context,

                        "/login"

                    );


                  },



                  child:

                  const Text(

                      "Já tenho conta"

                  ),



                )





              ],



            ),




          ),



        ),




      ),




    );



  }









  InputDecoration campo(

      String texto,

      IconData icone

      ){



    return InputDecoration(



      labelText:

      texto,



      prefixIcon:

      Icon(
          icone
      ),



      border:

      OutlineInputBorder(



        borderRadius:

        BorderRadius.circular(10),



      ),



    );



  }




}