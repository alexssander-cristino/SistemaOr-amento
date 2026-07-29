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


        return view('admin.orcamentos',[


            'eventos'=>Evento::with([

                'cliente',
                'categoria',
                'servicos.servico'

            ])
            ->orderBy('data')
            ->get(),




            'orcamentos'=>Orcamento::with([

                'evento.cliente',
                'evento.categoria',
                'evento.servicos.servico',
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


        $request->validate([


            'evento_id'=>[
                'required',
                'exists:eventos,id'
            ]


        ]);






        $evento = Evento::with([

            'servicos'

        ])
        ->findOrFail(
            $request->evento_id
        );








        if($evento->servicos->count() == 0)
        {


            return redirect()

                ->route('admin.orcamentos')

                ->with(

                    'error',

                    'Este evento não possui serviços cadastrados.'

                );


        }









        if(
            Orcamento::where(
                'evento_id',
                $evento->id
            )
            ->exists()
        )
        {


            return redirect()

                ->route('admin.orcamentos')

                ->with(

                    'error',

                    'Já existe orçamento para esse evento.'

                );


        }










        $total = 0;



        foreach($evento->servicos as $item)
        {


            $total += $item->subtotal ?? 0;


        }









        $orcamento = Orcamento::create([


            'evento_id'=>$evento->id,


            'desconto'=>0,


            'valor_total'=>$total,


            'status'=>'pendente'


        ]);









        foreach($evento->servicos as $item)
        {


            OrcamentoServico::create([


                'orcamento_id'=>$orcamento->id,


                'servico_id'=>$item->servico_id,


                'quantidade'=>$item->quantidade,


                'valor_unitario'=>$item->valor_unitario,


                'subtotal'=>$item->subtotal



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

                'Orçamento removido!'

            );


    }


}