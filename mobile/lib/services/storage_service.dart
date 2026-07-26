import 'package:shared_preferences/shared_preferences.dart';



class StorageService{



static Future saveToken(String token)
async{


final prefs =
await SharedPreferences.getInstance();


await prefs.setString(
"token",
token
);


}





static Future<String?> token()
async{


final prefs =
await SharedPreferences.getInstance();


return prefs.getString("token");


}





static Future logout()
async{


final prefs =
await SharedPreferences.getInstance();


await prefs.clear();


}


}