<?php

namespace App\Http\Controllers;


use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;



class RegisterController extends Controller
{


    public function index()
    {

        return view('auth.register');

    }





    public function store(Request $request)
    {


        $dados = $request->validate([


            'name'=>[
                'required',
                'string',
                'max:255'
            ],



            'email'=>[
                'required',
                'email',
                'unique:users,email'
            ],



            'password'=>[
                'required',
                'min:6',
                'confirmed'
            ]



        ]);






        User::create([


            'name'=>$dados['name'],


            'email'=>$dados['email'],


            'password'=>Hash::make(
                $dados['password']
            )


        ]);







        return redirect()

            ->route('login')

            ->with(
                'success',
                'Usuário cadastrado! Faça login para acessar.'
            );


    }


}