<?php

namespace App\Http\Controllers;

use App\Models\Servico;
use Illuminate\Http\Request;

class ServicoController extends Controller
{
    public function index()
    {
        return response()->json(
            Servico::with('categoria')->get()
        );
    }

    public function store(Request $request)
    {
        $dados = $request->validate([
            'categoria_id' => 'required|exists:categorias_servicos,id',
            'nome' => 'required',
            'descricao' => 'nullable',
            'valor' => 'required|numeric'
        ]);

        return response()->json(Servico::create($dados), 201);
    }

    public function show($id)
    {
        return response()->json(
            Servico::with('categoria')->findOrFail($id)
        );
    }

    public function update(Request $request, $id)
    {
        $servico = Servico::findOrFail($id);

        $servico->update($request->all());

        return response()->json($servico);
    }

    public function destroy($id)
    {
        Servico::findOrFail($id)->delete();

        return response()->json([
            'message' => 'Serviço removido.'
        ]);
    }
}