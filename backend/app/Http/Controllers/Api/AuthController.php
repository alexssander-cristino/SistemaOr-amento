<?php

namespace App\Http\Controllers\Api;


use App\Http\Controllers\Controller;

use Illuminate\Http\Request;

use App\Models\User;

use Illuminate\Support\Facades\Hash;



class AuthController extends Controller
{


public function register(Request $request)
{


$dados = $request->validate([

'name'=>'required',

'email'=>'required|email|unique:users',

'password'=>'required|min:6'

]);



$user = User::create([

'name'=>$dados['name'],

'email'=>$dados['email'],

'password'=>Hash::make($dados['password'])

]);



return response()->json([

'message'=>'Usuário criado',

'user'=>$user

]);


}





public function login(Request $request)
{


$request->validate([

'email'=>'required',

'password'=>'required'

]);



$user = User::where(
'email',
$request->email
)->first();



if(!$user || !Hash::check(
$request->password,
$user->password
)){


return response()->json([

'message'=>'Login inválido'

],401);


}





$token = $user->createToken(
'flutter'
)->plainTextToken;



return response()->json([


'token'=>$token,


'user'=>$user


]);


}



}