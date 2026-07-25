<?php

namespace App\Http\Controllers;


use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;



class PerfilController extends Controller
{


    public function index()
    {

        return view('perfil.index');

    }



    public function update(Request $request)
    {


        $user = auth()->user();



        $dados = $request->validate([

            'name'=>'required|string|max:255',

            'email'=>'required|email',

            'foto'=>'nullable|image|max:2048',

            'password'=>'nullable|min:6'

        ]);





        $user->name = $dados['name'];

        $user->email = $dados['email'];




        if($request->hasFile('foto')){


            $path = $request->file('foto')
                ->store('usuarios','public');


            $user->foto = $path;


        }




        if($request->password){


            $user->password =
                Hash::make($request->password);


        }




        $user->save();




        return back()
            ->with(
                'success',
                'Perfil atualizado com sucesso!'
            );


    }



}