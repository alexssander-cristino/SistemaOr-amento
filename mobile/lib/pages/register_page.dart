import 'package:flutter/material.dart';
import '../services/api_service.dart';



class RegisterPage extends StatefulWidget {


  const RegisterPage({super.key});


  @override
  State<RegisterPage> createState() => _RegisterPageState();


}





class _RegisterPageState extends State<RegisterPage> {



  final nome = TextEditingController();

  final email = TextEditingController();

  final senha = TextEditingController();





  @override
  void dispose(){

    nome.dispose();

    email.dispose();

    senha.dispose();

    super.dispose();

  }








  Future<void> cadastrar() async {



    if(nome.text.isEmpty ||
       email.text.isEmpty ||
       senha.text.isEmpty){


      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Preencha todos os campos"
          ),

        ),

      );


      return;

    }






    try{


      bool sucesso = await ApiService.register(

        nome.text,

        email.text,

        senha.text

      );







      if(sucesso){


        ScaffoldMessenger.of(context).showSnackBar(

          const SnackBar(

            content: Text(
              "Usuário cadastrado com sucesso!"
            ),

          ),

        );



        Navigator.pushReplacementNamed(

          context,

          '/login'

        );


      }else{


        ScaffoldMessenger.of(context).showSnackBar(

          const SnackBar(

            content: Text(
              "Erro ao cadastrar usuário"
            ),

          ),

        );


      }






    }catch(e){


      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(

          content: Text(
            "Erro de conexão: $e"
          ),

        ),

      );


    }



  }










  @override
  Widget build(BuildContext context){



    return Scaffold(


      backgroundColor: Colors.grey[100],



      body: Center(



        child: Container(


          width:350,


          padding:const EdgeInsets.all(25),



          decoration:BoxDecoration(


            color:Colors.white,


            borderRadius:BorderRadius.circular(15),


            boxShadow:[

              BoxShadow(

                color:Colors.black12,

                blurRadius:10,

              )

            ]

          ),





          child:Column(


            mainAxisSize:MainAxisSize.min,



            children:[





              const Text(

                "Criar Usuário",


                style:TextStyle(

                  fontSize:26,

                  fontWeight:FontWeight.bold

                ),


              ),





              const SizedBox(height:25),







              TextField(


                controller:nome,


                decoration:InputDecoration(


                  labelText:"Nome",


                  border:OutlineInputBorder(

                    borderRadius:BorderRadius.circular(10)

                  )


                ),


              ),





              const SizedBox(height:15),






              TextField(


                controller:email,


                keyboardType:TextInputType.emailAddress,


                decoration:InputDecoration(


                  labelText:"Email",


                  border:OutlineInputBorder(

                    borderRadius:BorderRadius.circular(10)

                  )


                ),


              ),






              const SizedBox(height:15),






              TextField(


                controller:senha,


                obscureText:true,


                decoration:InputDecoration(


                  labelText:"Senha",


                  border:OutlineInputBorder(

                    borderRadius:BorderRadius.circular(10)

                  )


                ),


              ),






              const SizedBox(height:25),






              SizedBox(


                width:double.infinity,


                child:ElevatedButton(


                  onPressed:cadastrar,



                  style:ElevatedButton.styleFrom(


                    padding:
                    const EdgeInsets.all(15),


                    backgroundColor:
                    Colors.blue,


                    shape:RoundedRectangleBorder(

                      borderRadius:
                      BorderRadius.circular(10)

                    )


                  ),




                  child:const Text(

                    "Cadastrar",


                    style:TextStyle(

                      color:Colors.white,

                      fontSize:16

                    ),


                  ),


                ),


              ),






              TextButton(


                onPressed:(){


                  Navigator.pushReplacementNamed(

                    context,

                    '/login'

                  );


                },


                child:const Text(

                  "Já tenho conta"


                ),


              )




            ],


          ),


        ),


      ),


    );


  }



}