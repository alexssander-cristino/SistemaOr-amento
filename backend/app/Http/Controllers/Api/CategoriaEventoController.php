<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\CategoriaEvento;
use Illuminate\Http\Request;

class CategoriaEventoController extends Controller
{
    public function index()
    {
        return response()->json(
            CategoriaEvento::all()
        );
    }

    public function store(Request $request)
    {
        $request->validate([
            'nome' => 'required|string|max:255',
        ]);

        $categoria = CategoriaEvento::create([
            'nome' => $request->nome,
        ]);

        return response()->json($categoria, 201);
    }

    public function show(CategoriaEvento $categoriaEvento)
    {
        return response()->json($categoriaEvento);
    }

    public function update(Request $request, CategoriaEvento $categoriaEvento)
    {
        $request->validate([
            'nome' => 'required|string|max:255',
        ]);

        $categoriaEvento->update([
            'nome' => $request->nome,
        ]);

        return response()->json($categoriaEvento);
    }

    public function destroy(CategoriaEvento $categoriaEvento)
    {
        $categoriaEvento->delete();

        return response()->json([
            'ok' => true,
        ]);
    }
}