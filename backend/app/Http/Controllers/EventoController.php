<?php

namespace App\Http\Controllers;

use App\Models\Evento;
use Illuminate\Http\Request;

class EventoController extends Controller
{
    public function index()
    {
        return response()->json(Evento::with('cliente')->get());
    }

    public function store(Request $request)
    {
        $dados = $request->validate([
            'cliente_id' => 'required|exists:clientes,id',
            'tipo' => 'required',
            'data' => 'required|date',
            'hora' => 'required',
            'local' => 'required',
            'quantidade_convidados' => 'required|integer',
            'observacoes' => 'nullable'
        ]);

        return response()->json(Evento::create($dados), 201);
    }

    public function show($id)
    {
        return response()->json(Evento::with('cliente')->findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $evento = Evento::findOrFail($id);

        $evento->update($request->all());

        return response()->json($evento);
    }

    public function destroy($id)
    {
        Evento::findOrFail($id)->delete();

        return response()->json([
            'message' => 'Evento removido.'
        ]);
    }
}