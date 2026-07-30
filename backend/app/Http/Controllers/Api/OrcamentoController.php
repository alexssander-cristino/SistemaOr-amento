<?php

namespace App\Http\Controllers\Api;


use App\Http\Controllers\Controller;

use App\Models\Orcamento;
use App\Models\Evento;
use App\Models\OrcamentoServico;

use Illuminate\Http\Request;



class OrcamentoController extends Controller
{


    /**
     * Lista todos os orçamentos
     */
    public function index()
    {


        $orcamentos = Orcamento::with([


            'evento.cliente',

            'evento.categoria',

            'itens.servico',

            'pagamentos'


        ])

        ->orderBy(

            'id',

            'desc'

        )

        ->get();





        return response()->json(

            $orcamentos

        );


    }









    /**
     * Criar orçamento automaticamente pelos serviços do evento
     */
    public function store(Request $request)
    {


        $dados = $request->validate([



            'evento_id'=>[

                'required',

                'exists:eventos,id'

            ],




            'desconto'=>[

                'nullable',

                'numeric'

            ],





            'status'=>[

                'required',

                'string'

            ]



        ]);









        /*
        |--------------------------------------------------------------------------
        | Buscar evento com serviços
        |--------------------------------------------------------------------------
        */


        $evento = Evento::with([

            'servicos'


        ])

        ->findOrFail(

            $request->evento_id

        );








        if($evento->servicos->count() == 0)
        {


            return response()->json([


                'message'=>

                'Este evento não possui serviços cadastrados.'



            ],400);


        }









        /*
        |--------------------------------------------------------------------------
        | Calcular total
        |--------------------------------------------------------------------------
        */


        $total = 0;



        foreach($evento->servicos as $servico)
        {


            $quantidade =

            $servico->pivot->quantidade

            ??

            1;





            $valor =

            $servico->pivot->valor_unitario

            ??

            $servico->valor;






            $total +=

            $quantidade * $valor;



        }









        /*
        |--------------------------------------------------------------------------
        | Criar orçamento
        |--------------------------------------------------------------------------
        */


        $orcamento = Orcamento::create([



            'evento_id'=>

            $evento->id,



            'desconto'=>

            $request->desconto ?? 0,



            'valor_total'=>

            $total,



            'status'=>

            $request->status



        ]);









        /*
        |--------------------------------------------------------------------------
        | Copiar serviços para orçamento
        |--------------------------------------------------------------------------
        */


        foreach($evento->servicos as $servico)
        {



            $quantidade =

            $servico->pivot->quantidade

            ??

            1;





            $valor =

            $servico->pivot->valor_unitario

            ??

            $servico->valor;








            OrcamentoServico::create([




                'orcamento_id'=>

                $orcamento->id,





                'servico_id'=>

                $servico->id,





                'quantidade'=>

                $quantidade,





                'valor_unitario'=>

                $valor,





                'subtotal'=>

                $quantidade * $valor





            ]);



        }









        /*
        |--------------------------------------------------------------------------
        | Retornar orçamento completo
        |--------------------------------------------------------------------------
        */


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












    /**
     * Mostrar um orçamento
     */
    public function show($id)
    {


        $orcamento = Orcamento::with([


            'evento.cliente',

            'evento.categoria',

            'itens.servico',

            'pagamentos'


        ])

        ->findOrFail($id);





        return response()->json(

            $orcamento

        );


    }












    /**
     * Atualizar orçamento
     */
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






        return response()->json(



            Orcamento::with([


                'evento.cliente',


                'evento.categoria',


                'itens.servico',


                'pagamentos'


            ])

            ->find($id)



        );



    }













    /**
     * Excluir orçamento
     */
    public function destroy($id)
    {


        $orcamento = Orcamento::findOrFail($id);





        // Remove serviços vinculados

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