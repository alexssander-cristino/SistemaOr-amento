<?php

namespace App\Http\Controllers;

use App\Models\Pagamento;
use Illuminate\Http\Request;

class PagamentoController extends Controller
{
    public function index()
    {
        return response()->json(
            Pagamento::with('orcamento')->get()
        );
    }

    public function store(Request $request)
    {
        $dados = $request->validate([
            'orcamento_id' => 'required|exists:orcamentos,id',
            'forma_pagamento' => 'required',
            'valor' => 'required|numeric',
            'data_pagamento' => 'nullable|date',
            'status' => 'required'
        ]);

        return response()->json(
            Pagamento::create($dados),
            201
        );
    }

    public function show($id)
    {
        return response()->json(
            Pagamento::with('orcamento')->findOrFail($id)
        );
    }

    public function update(Request $request, $id)
    {
        $pagamento = Pagamento::findOrFail($id);

        $pagamento->update($request->all());

        return response()->json($pagamento);
    }

    public function destroy($id)
    {
        Pagamento::findOrFail($id)->delete();

        return response()->json([
            'message' => 'Pagamento removido.'
        ]);
    }
}