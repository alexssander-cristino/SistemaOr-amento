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


        $eventos = Evento::with([

            'cliente',

            'categoria',

            'servicos.servico'

        ])

        ->orderBy(
            'data',
            'asc'
        )

        ->get();







        $orcamentos = Orcamento::with([


            'evento.cliente',

            'evento.categoria',

            'itens.servico'


        ])

        ->orderBy(

            'created_at',

            'desc'

        )

        ->get();








        return view(

            'admin.orcamentos',

            compact(

                'eventos',

                'orcamentos'

            )

        );


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

            'servicos.servico'

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

                'Este evento não possui serviços.'

            );


        }









        $total = 0;





        foreach($evento->servicos as $item)
        {


            $subtotal = $item->subtotal;


            if(!$subtotal)
            {

                $subtotal =

                    ($item->quantidade ?? 1)

                    *

                    ($item->valor_unitario ?? 0);

            }



            $total += $subtotal;


        }










        $orcamento = Orcamento::create([



            'evento_id'=>

                $evento->id,



            'desconto'=>

                0,



            'valor_total'=>

                $total,



            'status'=>

                'pendente'


        ]);









        foreach($evento->servicos as $item)
        {


            OrcamentoServico::create([



                'orcamento_id'=>

                    $orcamento->id,



                'servico_id'=>

                    $item->servico_id,



                'quantidade'=>

                    $item->quantidade ?? 1,



                'valor_unitario'=>

                    $item->valor_unitario

                    ??

                    $item->servico->valor,



                'subtotal'=>

                    $item->subtotal

                    ??

                    (
                        ($item->quantidade ?? 1)

                        *

                        ($item->valor_unitario

                        ??

                        $item->servico->valor)
                    )


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

        )

        ->delete();






        $orcamento->delete();






        return redirect()

        ->route('admin.orcamentos')

        ->with(

            'success',

            'Orçamento removido!'

        );


    }



}