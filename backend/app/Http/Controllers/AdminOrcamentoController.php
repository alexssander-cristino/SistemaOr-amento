<?php

namespace App\Http\Controllers;

use App\Models\Evento;
use App\Models\Orcamento;
use App\Models\OrcamentoServico;
use Illuminate\Http\Request;

class AdminOrcamentoController extends Controller
{

    public function index()
    {
        return view('admin.orcamentos', [

            'eventos' => Evento::with([
                'cliente',
                'categoria',
                'servicos.servico'
            ])
            ->orderBy('data')
            ->get(),

            'orcamentos' => Orcamento::with([
                'evento.cliente',
                'evento.categoria',
                'evento.servicos.servico',
                'itens.servico'
            ])
            ->orderBy('created_at', 'desc')
            ->get()

        ]);
    }



    public function store(Request $request)
    {

        $request->validate([

            'evento_id' => [
                'required',
                'exists:eventos,id'
            ]

        ]);


        $evento = Evento::with([
            'servicos.servico'
        ])->findOrFail($request->evento_id);



        // Verifica se o evento possui serviços

        if ($evento->servicos->count() == 0) {

            return redirect()
                ->route('admin.orcamentos')
                ->with(
                    'error',
                    'Este evento não possui serviços cadastrados.'
                );

        }



        // Impede criar dois orçamentos para o mesmo evento

        $existe = Orcamento::where(
            'evento_id',
            $evento->id
        )->first();


        if ($existe) {

            return redirect()
                ->route('admin.orcamentos')
                ->with(
                    'error',
                    'Já existe um orçamento para este evento.'
                );

        }



        $valorTotal = 0;


        foreach ($evento->servicos as $item) {

            $valorTotal += $item->subtotal;

        }



        $orcamento = Orcamento::create([

            'evento_id' => $evento->id,

            'desconto' => 0,

            'valor_total' => $valorTotal,

            'status' => 'pendente'

        ]);




        foreach ($evento->servicos as $item) {

            OrcamentoServico::create([

                'orcamento_id' => $orcamento->id,

                'servico_id' => $item->servico_id,

                'quantidade' => $item->quantidade,

                'valor_unitario' => $item->valor_unitario,

                'subtotal' => $item->subtotal

            ]);

        }



        return redirect()
            ->route('admin.orcamentos')
            ->with(
                'success',
                'Orçamento criado com sucesso!'
            );

    }




    public function destroy($id)
    {

        $orcamento = Orcamento::findOrFail($id);


        OrcamentoServico::where(
            'orcamento_id',
            $orcamento->id
        )->delete();


        $orcamento->delete();


        return redirect()
            ->route('admin.orcamentos')
            ->with(
                'success',
                'Orçamento removido com sucesso!'
            );

    }

}