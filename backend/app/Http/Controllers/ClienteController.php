<?php

namespace App\Http\Controllers;

use App\Models\Cliente;
use Illuminate\Http\Request;

class ClienteController extends Controller
{
    public function index()
    {
        return response()->json(Cliente::all(), 200);
    }

    public function store(Request $request)
    {
        $dados = $request->validate([
            'nome' => 'required|string|max:150',
            'telefone' => 'required|string|max:20',
            'email' => 'nullable|email|max:150',
            'cpf_cnpj' => 'nullable|string|max:20',
            'endereco' => 'nullable|string'
        ]);

        $cliente = Cliente::create($dados);

        return response()->json($cliente, 201);
    }

    public function show($id)
    {
        $cliente = Cliente::find($id);

        if (!$cliente) {
            return response()->json([
                'message' => 'Cliente não encontrado.'
            ], 404);
        }

        return response()->json($cliente);
    }

    public function update(Request $request, $id)
    {
        $cliente = Cliente::find($id);

        if (!$cliente) {
            return response()->json([
                'message' => 'Cliente não encontrado.'
            ], 404);
        }

        $dados = $request->validate([
            'nome' => 'required|string|max:150',
            'telefone' => 'required|string|max:20',
            'email' => 'nullable|email|max:150',
            'cpf_cnpj' => 'nullable|string|max:20',
            'endereco' => 'nullable|string'
        ]);

        $cliente->update($dados);

        return response()->json($cliente);
    }

    public function destroy($id)
    {
        $cliente = Cliente::find($id);

        if (!$cliente) {
            return response()->json([
                'message' => 'Cliente não encontrado.'
            ], 404);
        }

        $cliente->delete();

        return response()->json([
            'message' => 'Cliente excluído com sucesso.'
        ]);
    }
}