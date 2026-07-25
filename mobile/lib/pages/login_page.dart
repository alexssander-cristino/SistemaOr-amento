import 'package:flutter/material.dart';
import '../services/api_service.dart';



class LoginPage extends StatefulWidget {


  const LoginPage({super.key});


  @override
  State<LoginPage> createState() => _LoginPageState();


}




class _LoginPageState extends State<LoginPage>{



final emailController = TextEditingController();

final senhaController = TextEditingController();





Future<void> login() async{


if(emailController.text.isEmpty ||
   senhaController.text.isEmpty){



ScaffoldMessenger.of(context).showSnackBar(

const SnackBar(

content:Text(
"Preencha todos os campos"
)

)

);


return;


}




String? token = await ApiService.login(


emailController.text,


senhaController.text


);





if(token != null){



Navigator.pushReplacementNamed(

context,

'/home'

);



}else{



ScaffoldMessenger.of(context).showSnackBar(

const SnackBar(

content:Text(
"Email ou senha inválidos"
)

)

);


}




}







@override
Widget build(BuildContext context){


return Scaffold(


backgroundColor:Colors.grey[100],



body:Center(


child:Container(


width:350,


padding:const EdgeInsets.all(25),



decoration:BoxDecoration(


color:Colors.white,


borderRadius:BorderRadius.circular(20),



boxShadow:[


BoxShadow(

blurRadius:10,

color:Colors.black12

)


]


),




child:Column(



mainAxisSize:MainAxisSize.min,



children:[





const Text(


"🎉 EventManager",


style:TextStyle(


fontSize:25,

fontWeight:FontWeight.bold


),


),





const SizedBox(height:30),






TextField(


controller:emailController,


decoration:const InputDecoration(


labelText:"Email",

border:OutlineInputBorder()


),


),





const SizedBox(height:15),





TextField(


controller:senhaController,


obscureText:true,



decoration:const InputDecoration(


labelText:"Senha",

border:OutlineInputBorder()


),



),






const SizedBox(height:20),






SizedBox(


width:double.infinity,



child:ElevatedButton(


onPressed:login,


child:const Text(

"Entrar"

)


),



),







TextButton(


onPressed:(){


Navigator.pushNamed(

context,

'/register'

);


},



child:const Text(

"Criar nova conta"

)



)





]


)



)



)



);



}



}