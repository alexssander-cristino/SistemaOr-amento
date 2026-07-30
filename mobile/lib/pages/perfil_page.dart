import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../services/api_service.dart';



class PerfilPage extends StatefulWidget {


  const PerfilPage({
    super.key
  });



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






  @override
  void dispose(){

    nomeController.dispose();

    emailController.dispose();

    super.dispose();

  }









  Future<void> carregarUsuario() async{


    try{


      final dados =
      await ApiService.usuario();



      print("USUARIO:");
      print(dados);




      if(!mounted)
        return;



      setState((){


        usuario =
            dados ?? {};



        nomeController.text =
            usuario['name'] ?? "";



        emailController.text =
            usuario['email'] ?? "";



        carregando = false;



      });



    }catch(e){



      print(e);



      setState((){

        carregando=false;

      });



      mostrarMensagem(
          "Erro ao carregar usuário"
      );


    }


  }









  String urlFoto(){



    // foto selecionada localmente

    if(foto != null){

      return foto!.path;

    }






    if(usuario['foto'] == null){

      return "";

    }






    String imagem =
    usuario['foto'].toString();




    if(imagem.isEmpty){

      return "";

    }







    // caso venha URL pronta

    if(imagem.startsWith("http")){

      return imagem;

    }







    String base =

    ApiService.baseUrl
        .replaceAll("/api", "")
        .replaceAll(RegExp(r'/$'), '');






    // remove storage/

    imagem =
        imagem.replaceFirst(
            "storage/",
            ""
        );





    // remove barra inicial

    imagem =
        imagem.replaceFirst(
            RegExp("^/"),
            ""
        );





    return

    "$base/storage/$imagem";


  }









  Future<void> escolherFoto() async{


    try{



      PermissionStatus permissao =

      await Permission.photos.request();




      if(permissao.isDenied){


        mostrarMensagem(
            "Permissão de fotos negada"
        );


        return;

      }





      final picker =
      ImagePicker();




      final imagem =

      await picker.pickImage(



          source:

          ImageSource.gallery,



          imageQuality:

          80



      );






      if(imagem != null){



        setState((){


          foto =
          File(imagem.path);



        });



        mostrarMensagem(
            "Imagem selecionada"
        );


      }




    }catch(e){


      print(e);



      mostrarMensagem(
          "Erro ao abrir galeria"
      );


    }


  }









  Future<void> enviarFoto() async{



    if(foto == null){


      mostrarMensagem(
          "Selecione uma foto primeiro"
      );


      return;


    }







    try{



      bool resultado =

      await ApiService.enviarFoto(
          foto!
      );






      if(resultado){



        setState((){

          foto=null;

        });





        await carregarUsuario();




        mostrarMensagem(
            "Foto atualizada"
        );




      }else{


        mostrarMensagem(
            "Erro ao enviar foto"
        );


      }






    }catch(e){


      print(e);



      mostrarMensagem(
          e.toString()
      );


    }



  }









  Future<void> salvarPerfil() async{



    try{



      await ApiService.atualizarPerfil(


          {


            "name":

            nomeController.text.trim(),



            "email":

            emailController.text.trim(),



          }


      );





      await carregarUsuario();





      mostrarMensagem(
          "Perfil atualizado"
      );





    }catch(e){



      mostrarMensagem(
          e.toString()
      );



    }



  }









  ImageProvider? imagemPerfil(){



    String imagem =
    urlFoto();




    if(imagem.isEmpty){

      return null;

    }






    if(imagem.startsWith("/data")){


      return FileImage(

          File(imagem)

      );

    }






    return NetworkImage(
        imagem
    );



  }









  void mostrarMensagem(String texto){


    ScaffoldMessenger.of(context)
        .showSnackBar(


        SnackBar(

          content:

          Text(texto),

        )


    );


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

        CircularProgressIndicator(),

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



                radius:

                65,



                backgroundImage:

                imagemPerfil(),





                child:

                imagemPerfil()==null


                    ?


                const Icon(

                    Icons.camera_alt,

                    size:45

                )



                    :



                null,



              ),



            ),






            const SizedBox(
                height:20
            ),







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






            const SizedBox(
                height:30
            ),







            TextField(


              controller:

              nomeController,



              decoration:

              const InputDecoration(


                  labelText:
                  "Nome",



                  prefixIcon:

                  Icon(
                      Icons.person
                  )

              ),


            ),







            const SizedBox(
                height:15
            ),








            TextField(


              controller:

              emailController,



              decoration:

              const InputDecoration(


                  labelText:
                  "Email",



                  prefixIcon:

                  Icon(
                      Icons.email
                  )

              ),


            ),








            const SizedBox(
                height:30
            ),








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




          ],


        ),


      ),



    );


  }



}