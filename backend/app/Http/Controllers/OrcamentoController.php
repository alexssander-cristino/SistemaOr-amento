<?php

namespace App\Http\Controllers;

use App\Models\Orcamento;
use Illuminate\Http\Request;

class OrcamentoController extends Controller
{
    public function index()
    {
        return response()->json(
            Orcamento::with(['evento', 'itens'])->get()
        );
    }

    public function store(Request $request)
    {
        $dados = $request->validate([
            'evento_id' => 'required|exists:eventos,id',
            'desconto' => 'numeric',
            'valor_total' => 'numeric',
            'status' => 'required'
        ]);

        return response()->json(
            Orcamento::create($dados),
            201
        );
    }

    public function show($id)
    {
        return response()->json(
            Orcamento::with(['evento', 'itens'])->findOrFail($id)
        );
    }

    public function update(Request $request, $id)
    {
        $orcamento = Orcamento::findOrFail($id);

        $orcamento->update($request->all());

        return response()->json($orcamento);
    }

    public function destroy($id)
    {
        Orcamento::findOrFail($id)->delete();

        return response()->json([
            'message' => 'Orçamento removido.'
        ]);
    }
}