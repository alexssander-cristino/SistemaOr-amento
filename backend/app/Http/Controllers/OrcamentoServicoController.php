<?php

namespace App\Http\Controllers;

use App\Models\OrcamentoServico;
use Illuminate\Http\Request;

class OrcamentoServicoController extends Controller
{
    public function index()
    {
        return response()->json(
            OrcamentoServico::with(['orcamento', 'servico'])->get()
        );
    }

    public function store(Request $request)
    {
        $dados = $request->validate([
            'orcamento_id' => 'required|exists:orcamentos,id',
            'servico_id' => 'required|exists:servicos,id',
            'quantidade' => 'required|integer',
            'valor_unitario' => 'required|numeric',
            'subtotal' => 'required|numeric'
        ]);

        return response()->json(
            OrcamentoServico::create($dados),
            201
        );
    }

    public function show($id)
    {
        return response()->json(
            OrcamentoServico::with(['orcamento', 'servico'])->findOrFail($id)
        );
    }

    public function update(Request $request, $id)
    {
        $item = OrcamentoServico::findOrFail($id);

        $item->update($request->all());

        return response()->json($item);
    }

    public function destroy($id)
    {
        OrcamentoServico::findOrFail($id)->delete();

        return response()->json([
            'message' => 'Item removido.'
        ]);
    }
}