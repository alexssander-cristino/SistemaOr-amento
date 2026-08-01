<?php

namespace App\Http\Controllers\Api;


use App\Http\Controllers\Controller;

use App\Models\Orcamento;

use App\Models\Evento;

use App\Models\OrcamentoServico;

use Illuminate\Http\Request;



class OrcamentoController extends Controller
{


    public function index()
    {


        return response()->json(

            Orcamento::with([

                'evento.cliente',

                'evento.categoria',

                'itens.servico',

                'pagamentos'

            ])

            ->orderBy('id','desc')

            ->get()

        );


    }






    public function store(Request $request)
    {


        $dados = $request->validate([


            'evento_id'=>'required|exists:eventos,id',


            'desconto'=>'nullable|numeric',


            'status'=>'required|string'


        ]);






        $evento = Evento::with([

            'servicos.servico'

        ])

        ->findOrFail(

            $dados['evento_id']

        );







        if($evento->servicos->count() == 0)
        {

            return response()->json([

                'message'=>

                'Este evento não possui serviços.'

            ],400);

        }







        $total = 0;





        foreach($evento->servicos as $item)
        {


            $quantidade = 

            $item->quantidade ?? 1;




            $valor = 

            $item->valor_unitario

            ??

            $item->servico->valor;





            $total +=

            $quantidade * $valor;


        }






        $total -= $dados['desconto'] ?? 0;








        $orcamento = Orcamento::create([


            'evento_id'=>

            $evento->id,



            'desconto'=>

            $dados['desconto'] ?? 0,



            'valor_total'=>

            $total,



            'status'=>

            $dados['status']


        ]);









        foreach($evento->servicos as $item)
        {


            $quantidade =

            $item->quantidade ?? 1;





            $valor =

            $item->valor_unitario

            ??

            $item->servico->valor;








            OrcamentoServico::create([



                'orcamento_id'=>

                $orcamento->id,



                'servico_id'=>

                $item->servico_id,



                'quantidade'=>

                $quantidade,



                'valor_unitario'=>

                $valor,



                'subtotal'=>

                $quantidade * $valor



            ]);


        }









        return response()->json(


            Orcamento::with([

                'evento.cliente',

                'evento.categoria',

                'itens.servico',

                'pagamentos'


            ])

            ->find($orcamento->id),


            201


        );


    }








    public function show($id)
    {


        return response()->json(


            Orcamento::with([

                'evento.cliente',

                'evento.categoria',

                'itens.servico',

                'pagamentos'


            ])

            ->findOrFail($id)


        );


    }








    public function update(Request $request,$id)
    {


        $orcamento = Orcamento::findOrFail($id);




        $orcamento->update([


            'desconto'=>

            $request->desconto

            ??

            $orcamento->desconto,



            'valor_total'=>

            $request->valor_total

            ??

            $orcamento->valor_total,



            'status'=>

            $request->status

            ??

            $orcamento->status


        ]);





        return response()->json($orcamento);


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






        return response()->json([


            'message'=>

            'Orçamento removido com sucesso'


        ]);


    }


}