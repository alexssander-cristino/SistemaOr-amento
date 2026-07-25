<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class AdminPerfilController extends Controller
{


    public function index()
    {

        return view('admin.perfil', [

            'usuario' => Auth::user()

        ]);

    }




    public function update(Request $request)
    {


        $usuario = Auth::user();



        $dados = $request->validate([


            'name'=>[
                'required',
                'string',
                'max:255'
            ],


            'email'=>[
                'required',
                'email',
                'unique:users,email,'.$usuario->id
            ],


            'foto'=>[
                'nullable',
                'image',
                'max:2048'
            ],


            'password'=>[
                'nullable',
                'min:6',
                'confirmed'
            ]


        ]);






        $usuario->name = $dados['name'];

        $usuario->email = $dados['email'];





        if($request->hasFile('foto')){


            $arquivo = $request->file('foto')
                ->store('usuarios','public');


            $usuario->foto = $arquivo;


        }





        if(!empty($dados['password'])){


            $usuario->password =
                Hash::make($dados['password']);


        }






        $usuario->save();





        return redirect()

            ->route('admin.perfil')

            ->with(
                'success',
                'Perfil atualizado com sucesso!'
            );


    }


}