import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CategoriasEventoPage extends StatefulWidget {
  const CategoriasEventoPage({super.key});

  @override
  State<CategoriasEventoPage> createState() =>
      _CategoriasEventoPageState();
}

class _CategoriasEventoPageState
    extends State<CategoriasEventoPage> {
  final TextEditingController nomeController =
      TextEditingController();

  bool carregando = true;
  bool salvando = false;

  List<dynamic> categorias = [];

  @override
  void initState() {
    super.initState();
    carregar();
  }

  @override
  void dispose() {
    nomeController.dispose();
    super.dispose();
  }

  Future<void> carregar() async {
    setState(() {
      carregando = true;
    });

    try {
      final dados =
          await ApiService.categoriasEvento();

      if (!mounted) return;

      setState(() {
        categorias = List<dynamic>.from(dados);
      });

      debugPrint("Categorias carregadas:");
      debugPrint(categorias.toString());
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Erro ao carregar categorias\n$e",
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          carregando = false;
        });
      }
    }
  }

  Future<void> salvar() async {
    final nome = nomeController.text.trim();

    if (nome.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Informe o nome da categoria.",
          ),
        ),
      );
      return;
    }

    setState(() {
      salvando = true;
    });

    try {
      await ApiService.post(
        "categorias-evento",
        {
          "nome": nome,
        },
      );

      nomeController.clear();

      await carregar();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Categoria cadastrada com sucesso!",
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Erro ao cadastrar\n$e",
          ),
        ),
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
          "Categorias de Evento",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: "Nome da categoria",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: salvando ? null : salvar,
                child: salvando
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Text("Cadastrar"),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: carregando
                  ? const Center(
                      child:
                          CircularProgressIndicator(),
                    )
                  : categorias.isEmpty
                      ? const Center(
                          child: Text(
                            "Nenhuma categoria cadastrada.",
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: carregar,
                          child: ListView.builder(
                            itemCount:
                                categorias.length,
                            itemBuilder:
                                (context, index) {
                              final categoria =
                                  categorias[index];

                              return Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(
                                      "${categoria['id']}",
                                    ),
                                  ),
                                  title: Text(
                                    categoria['nome']
                                        .toString(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}