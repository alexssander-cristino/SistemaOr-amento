<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class UsuarioController extends Controller
{

    public function update(Request $request)
    {

        $usuario = auth()->user();


        $usuario->update([
            'name' => $request->name,
            'email' => $request->email,
        ]);


        return response()->json([
            'message'=>'Usuário atualizado',
            'usuario'=>$usuario
        ]);

    }



    public function foto(Request $request)
    {

        if(!$request->hasFile('foto')){

            return response()->json([
                'message'=>'Nenhuma foto enviada'
            ],400);

        }


        $path = $request
            ->file('foto')
            ->store('usuarios');


        $usuario = auth()->user();


        $usuario->update([
            'foto'=>$path
        ]);


        return response()->json([
            'message'=>'Foto atualizada',
            'foto'=>$path
        ]);

    }

}