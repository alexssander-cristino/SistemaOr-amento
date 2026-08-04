import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';

class EventoCadastroPage extends StatefulWidget {

  const EventoCadastroPage({
    super.key,
  });

  @override
  State<EventoCadastroPage> createState() =>
      _EventoCadastroPageState();
}

class _EventoCadastroPageState
    extends State<EventoCadastroPage> {

  final dataController = TextEditingController();

  final horaController = TextEditingController();

  final localController = TextEditingController();

  final convidadosController =
      TextEditingController();

  final observacoesController =
      TextEditingController();

  List clientes = [];

  List categorias = [];

  int? clienteSelecionado;

  int? categoriaSelecionada;

  bool carregando = true;

  bool salvando = false;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  @override
  void dispose() {

    dataController.dispose();

    horaController.dispose();

    localController.dispose();

    convidadosController.dispose();

    observacoesController.dispose();

    super.dispose();
  }

  Future<void> carregarDados() async {

    try {

      clientes =
          await ApiService.clientes();

      categorias =
          await ApiService.categoriasEvento();

    } catch (e) {

      mostrarMensagem(
          "Erro ao carregar dados.\n$e");

    }

    if (mounted) {

      setState(() {

        carregando = false;

      });

    }

  }

  Future<void> selecionarData() async {

    final DateTime? data =
        await showDatePicker(

      context: context,

      locale: const Locale("pt", "BR"),

      initialDate: DateTime.now(),

      firstDate: DateTime(2024),

      lastDate: DateTime(2100),

    );

    if (data != null) {

      dataController.text =
          DateFormat(
        "yyyy-MM-dd",
      ).format(data);

    }

  }

  Future<void> selecionarHora() async {

    final TimeOfDay? hora =
        await showTimePicker(

      context: context,

      initialTime:
          TimeOfDay.now(),

    );

    if (hora != null) {

      final agora =
          DateTime.now();

      final dataHora = DateTime(

        agora.year,

        agora.month,

        agora.day,

        hora.hour,

        hora.minute,

      );

      horaController.text =
          DateFormat(
        "HH:mm",
      ).format(dataHora);

    }

  }

  void mostrarMensagem(String texto) {

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        content: Text(texto),

      ),

    );

  }

  Future<void> salvar() async {

    if (clienteSelecionado == null) {

      mostrarMensagem(
          "Selecione o cliente.");

      return;
    }

    if (categoriaSelecionada == null) {

      mostrarMensagem(
          "Selecione a categoria.");

      return;
    }

    if (dataController.text.isEmpty) {

      mostrarMensagem(
          "Selecione a data.");

      return;
    }

    if (horaController.text.isEmpty) {

      mostrarMensagem(
          "Selecione a hora.");

      return;
    }

    if (localController.text.trim().isEmpty) {

      mostrarMensagem(
          "Informe o local.");

      return;
    }

    setState(() {

      salvando = true;

    });

    try {

      await ApiService.post(

        "eventos",

        {

          "cliente_id":
              clienteSelecionado,

          "categoria_evento_id":
              categoriaSelecionada,

          "data":
              dataController.text,

          "hora":
              horaController.text,

          "local":
              localController.text.trim(),

          "quantidade_convidados":

              int.tryParse(
                    convidadosController.text,
                  ) ??
                  1,

          "observacoes":
              observacoesController.text,

        },

      );

            if (!mounted) return;

      mostrarMensagem(
        "Evento cadastrado com sucesso!",
      );

      Navigator.pop(context);

    } catch (e) {

      mostrarMensagem(
        "Erro ao cadastrar evento:\n$e",
      );

    } finally {

      if (mounted) {

        setState(() {

          salvando = false;

        });

      }

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Novo Evento",
        ),

      ),

      body: carregando

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : SingleChildScrollView(

              padding:
                  const EdgeInsets.all(20),

              child: Column(

                children: [

                  DropdownButtonFormField<int>(

                    value:
                        clienteSelecionado,

                    decoration:
                        const InputDecoration(

                      labelText:
                          "Cliente",

                      border:
                          OutlineInputBorder(),

                    ),

                    items: clientes
                        .map<DropdownMenuItem<int>>(
                            (cliente) {

                      return DropdownMenuItem<int>(

                        value:
                            cliente["id"],

                        child: Text(
                          cliente["nome"],
                        ),

                      );

                    }).toList(),

                    onChanged: (valor) {

                      setState(() {

                        clienteSelecionado =
                            valor;

                      });

                    },

                  ),

                  const SizedBox(
                    height: 15,
                  ),

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

                    items: categorias
                        .map<DropdownMenuItem<int>>(
                            (categoria) {

                      return DropdownMenuItem<int>(

                        value:
                            categoria["id"],

                        child: Text(
                          categoria["nome"],
                        ),

                      );

                    }).toList(),

                    onChanged: (valor) {

                      setState(() {

                        categoriaSelecionada =
                            valor;

                      });

                    },

                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  TextField(

                    controller:
                        dataController,

                    readOnly: true,

                    onTap:
                        selecionarData,

                    decoration:
                        const InputDecoration(

                      labelText:
                          "Data",

                      prefixIcon: Icon(
                        Icons.calendar_today,
                      ),

                      border:
                          OutlineInputBorder(),

                    ),

                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  TextField(

                    controller:
                        horaController,

                    readOnly: true,

                    onTap:
                        selecionarHora,

                    decoration:
                        const InputDecoration(

                      labelText:
                          "Hora",

                      prefixIcon: Icon(
                        Icons.access_time,
                      ),

                      border:
                          OutlineInputBorder(),

                    ),

                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  TextField(

                    controller:
                        localController,

                    decoration:
                        const InputDecoration(

                      labelText:
                          "Local",

                      prefixIcon:
                          Icon(Icons.location_on),

                      border:
                          OutlineInputBorder(),

                    ),

                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  TextField(

                    controller:
                        convidadosController,

                    keyboardType:
                        TextInputType.number,

                    decoration:
                        const InputDecoration(

                      labelText:
                          "Quantidade de convidados",

                      prefixIcon:
                          Icon(Icons.people),

                      border:
                          OutlineInputBorder(),

                    ),

                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  TextField(

                    controller:
                        observacoesController,

                    maxLines: 4,

                    decoration:
                        const InputDecoration(

                      labelText:
                          "Observações",

                      prefixIcon:
                          Icon(Icons.description),

                      border:
                          OutlineInputBorder(),

                    ),

                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  SizedBox(

                    width:
                        double.infinity,

                    height: 50,

                    child:
                        ElevatedButton(

                      onPressed:

                          salvando
                              ? null
                              : salvar,

                      child:

                          salvando

                              ? const SizedBox(

                                  width: 24,

                                  height: 24,

                                  child:
                                      CircularProgressIndicator(

                                    strokeWidth: 3,

                                    color: Colors.white,

                                  ),

                                )

                              : const Text(
                                  "Salvar Evento",
                                ),

                    ),

                  ),

                ],

              ),

            ),

    );

  }

}