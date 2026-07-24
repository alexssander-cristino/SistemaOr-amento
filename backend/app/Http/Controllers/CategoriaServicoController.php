<?php

namespace App\Http\Controllers;

use App\Models\CategoriaServico;
use Illuminate\Http\Request;

class CategoriaServicoController extends Controller
{
    public function index()
    {
        return response()->json(
            CategoriaServico::all()
        );
    }


    public function store(Request $request)
    {
        $dados = $request->validate([
            'nome' => 'required|string|max:100'
        ]);

        return response()->json(
            CategoriaServico::create($dados),
            201
        );
    }


    public function show($id)
    {
        return response()->json(
            CategoriaServico::findOrFail($id)
        );
    }


    public function update(Request $request, $id)
    {
        $categoria = CategoriaServico::findOrFail($id);

        $categoria->update(
            $request->validate([
                'nome' => 'required|string|max:100'
            ])
        );

        return response()->json($categoria);
    }


    public function destroy($id)
    {
        CategoriaServico::findOrFail($id)->delete();

        return response()->json([
            'message' => 'Categoria removida com sucesso'
        ]);
    }
}