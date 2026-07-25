import 'dart:convert';
import 'package:http/http.dart' as http;


class AuthService {


static const String url = 
"http://SEU_IP:8000/api/login";



static Future<bool> login(

String email,

String senha

) async {



final response = await http.post(

Uri.parse(url),

headers:{

"Content-Type":"application/json"

},


body:jsonEncode({

"email":email,

"password":senha

}),


);



if(response.statusCode == 200){


return true;


}



return false;


}



}