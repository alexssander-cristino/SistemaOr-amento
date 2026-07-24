<?php

namespace App\Http\Controllers;

use App\Models\Orcamento;
use App\Models\Evento;
use App\Models\Servico;
use App\Models\OrcamentoServico;
use Illuminate\Http\Request;


class AdminOrcamentoController extends Controller
{


    public function index()
    {


        return view('admin.orcamentos',[


            'eventos'=>Evento::with([

                'cliente',
                'categoria',
                'servicos.servico'

            ])
            ->orderBy('data')
            ->get(),



            'servicos'=>Servico::with('categoria')
            ->orderBy('nome')
            ->get(),



            'orcamentos'=>Orcamento::with([

                'evento.cliente',
                'evento.categoria',
                'itens.servico'

            ])
            ->orderBy(
                'created_at',
                'desc'
            )
            ->get()



        ]);


    }






    public function store(Request $request)
    {


        $dados = $request->validate([


            'evento_id'=>[
                'required',
                'exists:eventos,id'
            ],


            'servicos'=>[
                'required',
                'array',
                'min:1'
            ],


            'servicos.*'=>[
                'exists:servicos,id'
            ]


        ]);





        $valorTotal = 0;



        foreach($request->servicos as $id)
        {


            $servico = Servico::findOrFail($id);


            $valorTotal += $servico->valor;


        }






        $orcamento = Orcamento::create([


            'evento_id'=>$request->evento_id,


            'desconto'=>0,


            'valor_total'=>$valorTotal,


            'status'=>'pendente'


        ]);







        foreach($request->servicos as $id)
        {


            $servico = Servico::findOrFail($id);



            OrcamentoServico::create([


                'orcamento_id'=>$orcamento->id,


                'servicio_id'=>$servico->id,


                'servico_id'=>$servico->id,


                'quantidade'=>1,


                'valor_unitario'=>$servico->valor,


                'subtotal'=>$servico->valor


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


        $orcamento->delete();



        return redirect()

            ->route('admin.orcamentos')

            ->with(

                'success',

                'Orçamento removido!'

            );


    }



}