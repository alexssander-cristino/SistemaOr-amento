import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/api_service.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  Map usuario = {};

  File? foto;

  bool carregando = true;

  final nomeController = TextEditingController();

  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    carregarUsuario();
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> carregarUsuario() async {
    try {
      final dados = await ApiService.usuario();

      debugPrint("USUARIO:");
      debugPrint(dados.toString());

      if (!mounted) return;

      setState(() {
        usuario = dados ?? {};

        nomeController.text = usuario["name"] ?? "";

        emailController.text = usuario["email"] ?? "";

        carregando = false;
      });
    } catch (e) {
      debugPrint(e.toString());

      if (!mounted) return;

      setState(() {
        carregando = false;
      });

      mostrarMensagem("Erro ao carregar usuário");
    }
  }

  String urlFoto() {
    if (foto != null) {
      return foto!.path;
    }

    if (usuario["foto"] == null) {
      return "";
    }

    String imagem = usuario["foto"].toString();

    if (imagem.isEmpty) {
      return "";
    }

    if (imagem.startsWith("http")) {
      return imagem;
    }

    String servidor =
        ApiService.baseUrl.replaceAll("/api", "").replaceAll(RegExp(r'/$'), "");

    imagem = imagem.replaceAll("\\", "/");

    if (imagem.startsWith("/")) {
      imagem = imagem.substring(1);
    }

    if (imagem.startsWith("storage/")) {
      imagem = imagem.replaceFirst("storage/", "");
    }

    return "$servidor/storage/$imagem";
  }

  ImageProvider? imagemPerfil() {
    String imagem = urlFoto();

    if (imagem.isEmpty) {
      return null;
    }

    if (!kIsWeb && File(imagem).existsSync()) {
      return FileImage(File(imagem));
    }

    return NetworkImage(imagem);
  }

    Future<void> escolherFoto() async {
    try {
      final ImagePicker picker = ImagePicker();

      final XFile? imagem = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (imagem == null) {
        return;
      }

      setState(() {
        foto = File(imagem.path);
      });

      mostrarMensagem("Imagem selecionada");
    } catch (e) {
      debugPrint("ERRO GALERIA:");
      debugPrint(e.toString());

      mostrarMensagem("Não foi possível abrir a galeria.");
    }
  }

  Future<void> enviarFoto() async {
    if (foto == null) {
      mostrarMensagem("Selecione uma foto primeiro");
      return;
    }

    try {
      bool sucesso = await ApiService.enviarFoto(foto!);

      if (!sucesso) {
        mostrarMensagem("Erro ao enviar foto");
        return;
      }

      setState(() {
        foto = null;
      });

      await carregarUsuario();

      mostrarMensagem("Foto atualizada com sucesso");
    } catch (e) {
      debugPrint(e.toString());

      mostrarMensagem("Erro ao enviar foto");
    }
  }

  Future<void> salvarPerfil() async {
    try {
      await ApiService.atualizarPerfil({
        "name": nomeController.text.trim(),
        "email": emailController.text.trim(),
      });

      await carregarUsuario();

      mostrarMensagem("Perfil atualizado");
    } catch (e) {
      debugPrint(e.toString());

      mostrarMensagem("Erro ao atualizar perfil");
    }
  }

  void mostrarMensagem(String texto) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(texto),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Minha Conta"),
        centerTitle: true,
      ),

      body: carregando
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [

                  CircleAvatar(
                    radius: 65,
                    backgroundColor: Colors.grey.shade300,

                    child: ClipOval(
                      child: SizedBox(
                        width: 130,
                        height: 130,

                        child: foto != null
                            ? Image.file(
                                foto!,
                                fit: BoxFit.cover,
                              )

                            : urlFoto().isNotEmpty

                                ? Image.network(
                                    urlFoto(),
                                    fit: BoxFit.cover,

                                    loadingBuilder: (
                                      context,
                                      child,
                                      progress,
                                    ) {
                                      if (progress == null) {
                                        return child;
                                      }

                                      return const Center(
                                        child:
                                            CircularProgressIndicator(),
                                      );
                                    },

                                    errorBuilder: (
                                      context,
                                      error,
                                      stackTrace,
                                    ) {
                                      debugPrint(error.toString());

                                      return const Icon(
                                        Icons.person,
                                        size: 70,
                                      );
                                    },
                                  )

                                : const Icon(
                                    Icons.person,
                                    size: 70,
                                  ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,

                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.photo),
                      label: const Text("Selecionar foto"),
                      onPressed: escolherFoto,
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.cloud_upload),
                      label: const Text("Enviar foto"),
                      onPressed: enviarFoto,
                    ),
                  ),

                  const SizedBox(height: 30),

                  TextField(
                    controller: nomeController,

                    decoration: const InputDecoration(
                      labelText: "Nome",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: emailController,

                    decoration: const InputDecoration(
                      labelText: "E-mail",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,

                    height: 50,

                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.save),
                      label: const Text("Salvar Alterações"),
                      onPressed: salvarPerfil,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}