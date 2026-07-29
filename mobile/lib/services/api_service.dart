import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';



class ApiService {


  static const String baseUrl =
      "http://192.168.1.36:8000/api";





  // ================= TOKEN =================


  static Future<String?> getToken() async {

    final prefs =
    await SharedPreferences.getInstance();


    return prefs.getString("token");

  }





  static Future<void> salvarToken(String token) async {


    final prefs =
    await SharedPreferences.getInstance();


    await prefs.setString(
        "token",
        token
    );


  }







  static Future<Map<String,String>> headers() async {


    final token =
    await getToken();



    return {


      "Accept":
      "application/json",


      "Content-Type":
      "application/json",


      if(token != null)

        "Authorization":
        "Bearer $token"


    };


  }








  // ================= LOGIN =================


  static Future<bool> login(
      String email,
      String senha
      ) async {



    final response =
    await http.post(


      Uri.parse(
          "$baseUrl/login"
      ),



      headers:{


        "Accept":
        "application/json",


        "Content-Type":
        "application/json"


      },



      body:jsonEncode({


        "email":
        email,


        "password":
        senha


      }),



    );





    print("LOGIN");
    print(response.body);





    if(response.statusCode == 200){


      final dados =
      jsonDecode(response.body);



      if(dados["token"] != null){


        await salvarToken(
            dados["token"]
        );


        return true;


      }



    }




    return false;



  }








  // ================= REGISTER =================


  static Future<bool> register(
      String nome,
      String email,
      String senha
      ) async {



    final response =
    await http.post(



      Uri.parse(
          "$baseUrl/register"
      ),



      headers:{


        "Accept":
        "application/json",


        "Content-Type":
        "application/json"


      },



      body:jsonEncode({



        "name":
        nome,


        "email":
        email,


        "password":
        senha,


        "password_confirmation":
        senha



      }),



    );




    print("REGISTER STATUS");
    print(response.statusCode);


    print("REGISTER BODY");
    print(response.body);




    return response.statusCode == 200 ||
        response.statusCode == 201;



  }









  // ================= GET =================



  static Future<dynamic> get(
      String rota
      ) async {



    final response =
    await http.get(



      Uri.parse(
          "$baseUrl/$rota"
      ),



      headers:
      await headers(),



    );





    print("====================");
    print("GET:");
    print(rota);

    print("STATUS:");
    print(response.statusCode);

    print("BODY:");
    print(response.body);

    print("====================");






    if(response.statusCode == 200){



      final dados =
      jsonDecode(response.body);





      if(dados is Map &&
          dados.containsKey("data")){


        return dados["data"];


      }





      return dados;



    }







    throw Exception(

        "Erro GET $rota\n${response.body}"

    );



  }









  // ================= POST =================


  static Future<dynamic> post(
      String rota,
      Map dados
      ) async {



    final response =
    await http.post(



      Uri.parse(
          "$baseUrl/$rota"
      ),



      headers:
      await headers(),



      body:
      jsonEncode(dados)



    );




    print("POST $rota");
    print(response.body);






    if(response.statusCode == 200 ||
        response.statusCode == 201){



      return jsonDecode(
          response.body
      );



    }






    throw Exception(
        response.body
    );



  }









  // ================= PUT =================



  static Future<dynamic> put(
      String rota,
      Map dados
      ) async {



    final response =
    await http.put(



      Uri.parse(
          "$baseUrl/$rota"
      ),



      headers:
      await headers(),



      body:
      jsonEncode(dados)



    );





    print("PUT $rota");
    print(response.body);






    if(response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204){



      if(response.body.isEmpty){

        return true;

      }



      return jsonDecode(
          response.body
      );



    }





    throw Exception(
        response.body
    );



  }









  // ================= DELETE =================



  static Future<bool> delete(
      String rota
      ) async {



    final response =
    await http.delete(



      Uri.parse(
          "$baseUrl/$rota"
      ),



      headers:
      await headers(),



    );





    print("DELETE $rota");
    print(response.body);




    return response.statusCode == 200 ||
        response.statusCode == 204;



  }









  // ================= LISTA PADRÃO =================



  static Future<List<dynamic>> lista(
      String rota
      ) async {



    final dados =
    await get(rota);





    if(dados is List){

      return dados;

    }





    if(dados is Map){



      if(dados["data"] is List){

        return dados["data"];

      }




      if(dados[rota] is List){

        return dados[rota];

      }




    }




    return [];



  }









  // ================= DADOS =================



  static Future<List<dynamic>> clientes() async {

    return await lista(
        "clientes"
    );

  }





  static Future<List<dynamic>> eventos() async {

    return await lista(
        "eventos"
    );

  }







  static Future<List<dynamic>> categorias() async {

    return await lista(
        "categorias"
    );

  }







  static Future<List<dynamic>> servicos() async {

    return await lista(
        "servicos"
    );

  }







  static Future<List<dynamic>> orcamentos() async {

    return await lista(
        "orcamentos"
    );

  }







  static Future<List<dynamic>> pagamentos() async {

    return await lista(
        "pagamentos"
    );

  }









  // ================= USUARIO =================



  static Future<dynamic> usuario() async {


    return await get(
        "usuario"
    );


  }






  static Future<bool> atualizarPerfil(
      Map dados
      ) async {



    await put(
        "usuario",
        dados
    );



    return true;


  }









  // ================= FOTO =================



  static Future<bool> enviarFoto(
      File foto
      ) async {



    final token =
    await getToken();




    var request =
    http.MultipartRequest(


        "POST",


        Uri.parse(
            "$baseUrl/usuario/foto"
        )


    );





    request.headers.addAll({



      "Authorization":
      "Bearer $token",



      "Accept":
      "application/json"



    });






    request.files.add(



        await http.MultipartFile.fromPath(


            "foto",


            foto.path,



            contentType:

            MediaType(
                "image",
                "jpeg"
            )


        )


    );







    final response =
    await request.send();






    return response.statusCode == 200;



  }









  // ================= LOGOUT =================



  static Future<void> logout() async {



    try{


      await post(
          "logout",
          {}
      );



    }catch(e){}




    final prefs =
    await SharedPreferences.getInstance();



    await prefs.remove(
        "token"
    );



  }





}