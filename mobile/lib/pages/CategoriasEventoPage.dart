import 'package:flutter/material.dart';
import '../services/api_service.dart';


class CategoriasEventoPage extends StatefulWidget {

  const CategoriasEventoPage({super.key});


  @override
  State<CategoriasEventoPage> createState() =>
      _CategoriasEventoPageState();

}



class _CategoriasEventoPageState
    extends State<CategoriasEventoPage>{


  List categorias = [];

  final nome =
  TextEditingController();


  @override
  void initState(){

    super.initState();

    carregar();

  }




  Future<void> carregar() async{

    categorias =
        await ApiService.categoriasEvento();

    setState((){});

  }





  Future<void> salvar() async{


    if(nome.text.trim().isEmpty)
      return;


    await ApiService.post(

      "categorias-evento",

      {

        "nome":
        nome.text.trim()

      },

    );


    nome.clear();

    carregar();


  }





  @override
  Widget build(BuildContext context){

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Categorias de Evento",
        ),
      ),


      body: Padding(

        padding:
        const EdgeInsets.all(20),


        child: Column(

          children:[


            TextField(

              controller:
              nome,

              decoration:
              const InputDecoration(

                labelText:
                "Nome da categoria",

                border:
                OutlineInputBorder(),

              ),

            ),


            const SizedBox(
              height:20,
            ),



            ElevatedButton(

              onPressed:
              salvar,

              child:
              const Text(
                "Cadastrar",
              ),

            ),



            Expanded(

              child:
              ListView.builder(

                itemCount:
                categorias.length,


                itemBuilder:
                (context,index){


                  return ListTile(

                    title:
                    Text(
                      categorias[index]["nome"],
                    ),

                  );


                },

              ),

            )


          ],

        ),

      ),

    );

  }


}