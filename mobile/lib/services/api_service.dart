import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';





class ApiService {



static const String baseUrl =
"http://192.168.100.166:8000/api";






// =======================
// TOKEN
// =======================


static Future<String?> getToken() async{


final prefs =
await SharedPreferences.getInstance();


return prefs.getString(
"token"
);


}







static Future<Map<String,String>> headers() async{


String? token =
await getToken();



return {


"Accept":
"application/json",


"Content-Type":
"application/json",


"Authorization":
"Bearer $token"



};



}









// =======================
// LOGIN
// =======================


static Future<String?> login(
String email,
String senha
) async{



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



body:

jsonEncode({


"email":email,


"password":senha



})



);






if(response.statusCode == 200){


final dados =
jsonDecode(response.body);



final token =
dados['token'];



final prefs =
await SharedPreferences.getInstance();



await prefs.setString(

"token",

token

);



return token;



}



return null;



}









// =======================
// REGISTRO
// =======================


static Future<bool> register(
String nome,
String email,
String senha
) async{


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



body:

jsonEncode({



"name":nome,


"email":email,


"password":senha,


"password_confirmation":senha



})



);



return response.statusCode == 200 ||
response.statusCode == 201;



}









// =======================
// USUARIO
// =======================


static Future<dynamic> usuario() async{


final response =
await http.get(



Uri.parse(
"$baseUrl/usuario"
),



headers:
await headers()



);



if(response.statusCode == 200){


return jsonDecode(
response.body
);


}


return null;


}











// =======================
// ATUALIZAR PERFIL
// =======================


static Future<bool> atualizarPerfil(
Map dados
) async{



final response =
await http.put(



Uri.parse(
"$baseUrl/usuario"
),



headers:
await headers(),



body:
jsonEncode(dados)



);



return response.statusCode == 200;



}









// =======================
// FOTO PERFIL
// =======================


static Future<bool> enviarFoto(
File foto
) async{



String? token =
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











// =======================
// GET GENERICO
// =======================


static Future<List<dynamic>> getDados(
String rota
) async{



final response =
await http.get(



Uri.parse(
"$baseUrl/$rota"
),



headers:
await headers()



);





if(response.statusCode == 200){


return jsonDecode(
response.body
);


}



return [];



}











// =======================
// POST
// =======================


static Future<bool> criar(
String rota,
Map dados
) async{



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



return response.statusCode == 200 ||
response.statusCode == 201;



}









// =======================
// PUT
// =======================


static Future<bool> atualizar(
String rota,
int id,
Map dados
) async{


final response =
await http.put(



Uri.parse(
"$baseUrl/$rota/$id"
),



headers:
await headers(),



body:
jsonEncode(dados)



);



return response.statusCode == 200;



}









// =======================
// DELETE
// =======================


static Future<bool> deletar(
String rota,
int id
) async{



final response =
await http.delete(



Uri.parse(
"$baseUrl/$rota/$id"
),



headers:
await headers()



);



return response.statusCode == 200 ||
response.statusCode == 204;



}











// =======================
// CLIENTES
// =======================


static Future<List<dynamic>> clientes()
async{


return await getDados(
"clientes"
);


}









// =======================
// EVENTOS
// =======================


static Future<List<dynamic>> eventos()
async{


return await getDados(
"eventos"
);


}









// =======================
// SERVICOS
// =======================


static Future<List<dynamic>> servicos()
async{


return await getDados(
"servicos"
);


}









// =======================
// CATEGORIAS
// =======================


static Future<List<dynamic>> categorias()
async{


return await getDados(
"categorias"
);


}









// =======================
// ORCAMENTOS
// =======================


static Future<List<dynamic>> orcamentos()
async{


return await getDados(
"orcamentos"
);


}









// =======================
// EVENTO + SERVICOS
// =======================


static Future<bool> criarEventoComServicos(
Map dados
) async{


return await criar(

"eventos",

dados

);



}









// =======================
// ORCAMENTO PDF
// =======================


static Future<dynamic> detalhesOrcamento(
int id
) async{



final response =
await http.get(



Uri.parse(
"$baseUrl/orcamentos/$id"
),



headers:
await headers()



);



if(response.statusCode==200){


return jsonDecode(
response.body
);


}



return null;



}









// =======================
// LOGOUT
// =======================


static Future<void> logout() async{



try{


await http.post(


Uri.parse(
"$baseUrl/logout"
),


headers:
await headers()



);



}catch(e){



}




final prefs =
await SharedPreferences.getInstance();



await prefs.remove(
"token"
);



}





}