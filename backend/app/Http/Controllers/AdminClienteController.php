<?php

namespace App\Http\Controllers;

use App\Models\Cliente;
use Illuminate\Http\Request;

class AdminClienteController extends Controller
{

    public function index()
    {
        return view('admin.clientes', [
            'clientes' => Cliente::all()
        ]);
    }


    public function store(Request $request)
    {

        $dados = $request->validate([

            'nome' => 'required|string|max:100',
            'telefone' => 'required|string',
            'email' => 'nullable|email',
            'cpf_cnpj' => 'nullable|string',
            'endereco' => 'nullable|string'

        ]);


        Cliente::create($dados);


        return redirect()
            ->route('admin.clientes')
            ->with('success','Cliente cadastrado!');
    }


    public function destroy($id)
    {
        Cliente::findOrFail($id)->delete();

        return redirect()
            ->route('admin.clientes');
    }

}