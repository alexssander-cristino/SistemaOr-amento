import 'package:flutter/material.dart';
import '../services/api_service.dart';


class ServicosFormPage extends StatefulWidget {

  const ServicosFormPage({
    super.key
  });


  @override
  State<ServicosFormPage> createState() =>
      _ServicosFormPageState();

}



class _ServicosFormPageState
    extends State<ServicosFormPage> {



  final nome =
      TextEditingController();


  final descricao =
      TextEditingController();


  final valor =
      TextEditingController();



  List categorias = [];


  int? categoriaSelecionada;


  bool carregando = false;


  bool carregandoCategorias = true;





  @override
  void initState(){

    super.initState();

    carregarCategorias();

  }







  Future<void> carregarCategorias() async {


    try{


      final dados =
          await ApiService.categorias();



      setState((){


        categorias = dados;


        carregandoCategorias = false;


      });



    }catch(e){


      setState((){

        carregandoCategorias = false;

      });



      mostrarMensagem(
          "Erro ao carregar categorias"
      );


    }


  }








  Future<void> salvar() async {



    if(nome.text.isEmpty ||
        valor.text.isEmpty ||
        categoriaSelecionada == null){


      mostrarMensagem(
          "Preencha todos os campos"
      );


      return;

    }




    setState((){

      carregando = true;

    });





    try{


      await ApiService.post(

        "servicos",

        {


          "nome":
          nome.text,


          "descricao":
          descricao.text,



          "valor":
          double.tryParse(
              valor.text.replaceAll(",", ".")
          ) ?? 0,



          "categoria_id":
          categoriaSelecionada


        },

      );




      if(!mounted)
        return;



      Navigator.pop(context);



    }catch(e){


      mostrarMensagem(
          e.toString()
      );


    }finally{


      setState((){

        carregando = false;

      });


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
            "Novo Serviço"
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

            crossAxisAlignment:
            CrossAxisAlignment.start,


            children: [





              TextField(

                controller:
                nome,


                decoration:
                const InputDecoration(

                  labelText:
                  "Nome do serviço",

                  border:
                  OutlineInputBorder(),

                ),

              ),






              const SizedBox(
                  height:15
              ),





              TextField(

                controller:
                descricao,


                maxLines:
                3,


                decoration:
                const InputDecoration(

                  labelText:
                  "Descrição",

                  border:
                  OutlineInputBorder(),

                ),

              ),






              const SizedBox(
                  height:15
              ),






              TextField(

                controller:
                valor,


                keyboardType:
                const TextInputType.numberWithOptions(
                    decimal:true
                ),


                decoration:
                const InputDecoration(

                  labelText:
                  "Valor",

                  prefixText:
                  "R\$ ",

                  border:
                  OutlineInputBorder(),

                ),

              ),






              const SizedBox(
                  height:15
              ),







              carregandoCategorias

                  ?

              const Center(

                child:
                CircularProgressIndicator(),

              )

                  :

              DropdownButtonFormField<int>(



                value:
                categoriaSelecionada,



                decoration:
                const InputDecoration(

                  labelText:
                  "Categoria",

                  border:
                  OutlineInputBorder(),

                ),



                items:

                categorias.map<DropdownMenuItem<int>>(
                        (categoria){


                      return DropdownMenuItem<int>(


                        value:
                        categoria["id"],



                        child:
                        Text(

                          categoria["nome"]

                              ??
                              categoria["categoria"]

                              ??
                              "Sem nome",

                        ),


                      );


                    }

                ).toList(),




                onChanged:
                    (valor){


                  setState((){


                    categoriaSelecionada =
                        valor;


                  });


                },


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
                  carregando
                      ?
                  null
                      :
                  salvar,



                  child:

                  carregando

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