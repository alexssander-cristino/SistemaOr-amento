import 'dart:convert';

import 'package:http/http.dart' as http;



class ApiService{


static const String baseUrl =
"http://SEU_IP:8000/api";



static Future<bool> register(
String nome,
String email,
String senha
) async {



final response = await http.post(

Uri.parse(
"$baseUrl/register"
),

headers:{


"Accept":"application/json",


"Content-Type":"application/json"


},


body:jsonEncode({


"name":nome,

"email":email,

"password":senha


})


);



return response.statusCode == 200;


}







static Future<String?> login(

String email,

String senha

) async {



final response = await http.post(

Uri.parse(
"$baseUrl/login"
),


headers:{


"Accept":"application/json",

"Content-Type":"application/json"


},



body:jsonEncode({


"email":email,

"password":senha


})


);



if(response.statusCode==200){


var dados=jsonDecode(response.body);


return dados['token'];


}



return null;


}



}