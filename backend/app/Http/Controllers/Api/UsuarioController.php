<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;


class UsuarioController extends Controller
{


    public function usuario()
    {

        $usuario = auth()->user();


        if($usuario->foto){

            $usuario->foto =
            asset(
                'storage/'.$usuario->foto
            );

        }



        return response()->json($usuario);

    }





    public function update(Request $request)
    {

        $usuario = auth()->user();


        $dados = $request->validate([

            'name'=>'required|string',

            'email'=>'required|email',

        ]);



        $usuario->update($dados);



        return response()->json([

            'message'=>'Usuário atualizado',

            'usuario'=>$usuario

        ]);

    }







    public function foto(Request $request)
    {


        $request->validate([

            'foto'=>
            'required|image|mimes:jpg,jpeg,png|max:2048'

        ]);




        $usuario = auth()->user();




        if($usuario->foto){


            Storage::disk('public')
            ->delete(
                $usuario->foto
            );


        }






        $path = $request
            ->file('foto')
            ->store(
                'usuarios',
                'public'
            );







        $usuario->update([

            'foto'=>$path

        ]);







        return response()->json([


            'message'=>'Foto atualizada',


            'foto'=>
            asset(
                'storage/'.$path
            ),


            'usuario'=>$usuario


        ]);



    }



}