import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/api_service.dart';



class PerfilPage extends StatefulWidget {


  const PerfilPage({super.key});


  @override
  State<PerfilPage> createState() =>
      _PerfilPageState();


}





class _PerfilPageState extends State<PerfilPage>{



  Map usuario = {};


  File? foto;


  bool carregando = true;



  final nomeController =
  TextEditingController();



  final emailController =
  TextEditingController();






  @override
  void initState(){

    super.initState();

    carregarUsuario();

  }









  Future<void> carregarUsuario() async{


    try{


      final dados =
      await ApiService.usuario();




      setState((){


        usuario =
        dados ?? {};



        nomeController.text =
            usuario['name'] ?? "";



        emailController.text =
            usuario['email'] ?? "";



        carregando=false;



      });



    }catch(e){


      print(e);


      setState((){

        carregando=false;

      });


    }



  }









  Future<void> escolherFoto() async{


    final picker =
    ImagePicker();



    final imagem =
    await picker.pickImage(



        source:
        ImageSource.gallery,



        imageQuality:80



    );



    if(imagem != null){


      setState((){


        foto =
        File(imagem.path);


      });



    }


  }









  Future<void> salvarPerfil() async{



    bool sucesso =

    await ApiService.atualizarPerfil(



      {

        "name":
        nomeController.text,


        "email":
        emailController.text,


      }



    );





    if(sucesso){


      ScaffoldMessenger.of(context)
          .showSnackBar(



          const SnackBar(

              content:

              Text(
                  "Perfil atualizado"
              )

          )

      );



    }



  }










  Future<void> enviarFoto() async{



    if(foto == null){

      return;

    }




    bool sucesso =

    await ApiService.enviarFoto(

        foto!

    );





    if(sucesso){



      ScaffoldMessenger.of(context)
          .showSnackBar(



          const SnackBar(

              content:

              Text(
                  "Foto atualizada"
              )

          )

      );



    }



  }









  @override
  Widget build(BuildContext context){



    return Scaffold(



      appBar:

      AppBar(

        title:

        const Text(
            "Minha Conta"
        ),


      ),





      body:

      carregando


          ?


      const Center(

        child:

        CircularProgressIndicator()

      )



          :



      SingleChildScrollView(



        padding:

        const EdgeInsets.all(20),




        child:

        Column(



          children:[





            GestureDetector(



              onTap:

              escolherFoto,



              child:

              CircleAvatar(



                radius:60,




                backgroundImage:


                foto != null


                    ?


                FileImage(foto!)



                    :

                usuario['foto'] != null


                    ?


                NetworkImage(

                    usuario['foto']

                )

                    :

                null



                as ImageProvider?,






                child:


                foto == null &&
                    usuario['foto']==null


                    ?


                const Icon(

                    Icons.camera_alt,

                    size:40

                )

                    :

                null,


              ),



            ),





            const SizedBox(height:20),





            ElevatedButton.icon(



              icon:

              const Icon(
                  Icons.upload
              ),



              label:

              const Text(
                  "Enviar foto"
              ),



              onPressed:

              enviarFoto,


            ),







            const SizedBox(height:30),







            TextField(



              controller:

              nomeController,



              decoration:

              const InputDecoration(



                  labelText:
                  "Nome",



                  prefixIcon:
                  Icon(Icons.person)



              ),



            ),





            const SizedBox(height:15),







            TextField(



              controller:

              emailController,



              decoration:

              const InputDecoration(



                  labelText:
                  "Email",



                  prefixIcon:
                  Icon(Icons.email)



              ),



            ),








            const SizedBox(height:30),







            SizedBox(



              width:

              double.infinity,



              child:

              ElevatedButton.icon(



                icon:

                const Icon(
                    Icons.save
                ),



                label:

                const Text(
                    "Salvar alterações"
                ),



                onPressed:

                salvarPerfil,



              ),


            )







          ]

        )

      )




    );


  }





}