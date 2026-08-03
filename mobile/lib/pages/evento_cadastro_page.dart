import 'package:flutter/material.dart';
import '../services/api_service.dart';

class EventoCadastroPage extends StatefulWidget {
  const EventoCadastroPage({super.key});

  @override
  State<EventoCadastroPage> createState() => _EventoCadastroPageState();
}

class _EventoCadastroPageState extends State<EventoCadastroPage> {

  final dataController = TextEditingController();
  final horaController = TextEditingController();
  final localController = TextEditingController();
  final convidadosController = TextEditingController();
  final observacoesController = TextEditingController();

  List categorias = [];

  int? categoriaSelecionada;

  bool salvando = false;
  bool carregandoCategorias = true;


  @override
  void initState() {
    super.initState();
    carregarCategorias();
  }


  Future<void> carregarCategorias() async {

    try {

      final dados = await ApiService.get(
        "categoria-eventos",
      );

      setState(() {

        categorias = dados;

        carregandoCategorias = false;

      });


    } catch(e) {

      mostrarMensagem(
        "Erro ao carregar categorias: $e"
      );

      setState(() {
        carregandoCategorias = false;
      });

    }

  }




  Future<void> salvar() async {


    if(categoriaSelecionada == null ||
       dataController.text.isEmpty) {

      mostrarMensagem(
        "Selecione a categoria e informe a data"
      );

      return;

    }



    setState(() {
      salvando = true;
    });



    try {


      await ApiService.post(

        "eventos",

        {

          "categoria_evento_id":
              categoriaSelecionada,


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



      if(!mounted) return;


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

        setState(() {
          salvando=false;
        });

      }

    }


  }




  void mostrarMensagem(String texto){

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text(texto),
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
      const EdgeInsets.only(bottom:15),

      child: TextField(

        controller: controller,

        decoration: InputDecoration(

          labelText: texto,

          prefixIcon: Icon(icone),

          border:
          const OutlineInputBorder(),

        ),

      ),

    );

  }




  @override
  Widget build(BuildContext context){

    return Scaffold(

      appBar: AppBar(

        title:
        const Text("Novo Evento"),

      ),


      body:

      SingleChildScrollView(

        padding:
        const EdgeInsets.all(20),


        child:

        Column(

          children:[



            carregandoCategorias

                ?

            const CircularProgressIndicator()


                :

            DropdownButtonFormField<int>(


              value:
              categoriaSelecionada,


              decoration:

              const InputDecoration(

                labelText:
                "Categoria do Evento",

                border:
                OutlineInputBorder(),

              ),



              items:

              categorias.map((categoria){


                return DropdownMenuItem<int>(


                  value:
                  categoria['id'],


                  child:
                  Text(
                    categoria['nome'],
                  ),


                );


              }).toList(),



              onChanged:(valor){


                setState(() {

                  categoriaSelecionada =
                      valor;

                });


              },


            ),



            const SizedBox(height:15),



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



            const SizedBox(height:20),



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

                const CircularProgressIndicator(
                  color: Colors.white,
                )


                    :

                const Text(
                  "Salvar Evento",
                ),


              ),


            )


          ],


        ),


      ),


    );

  }


}