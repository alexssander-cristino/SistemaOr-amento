<?php

namespace App\Http\Controllers\Api;


use App\Http\Controllers\Controller;
use App\Models\Orcamento;
use Illuminate\Http\Request;


class OrcamentoController extends Controller
{


    public function index()
    {

        return response()->json(

            Orcamento::with([

                'evento.cliente',
                'itens.servico',
                'pagamentos'

            ])->get()

        );

    }







    public function store(Request $request)
    {


        $dados = $request->validate([


            'evento_id'=>'required|exists:eventos,id',

            'valor_total'=>'required|numeric',

            'desconto'=>'nullable|numeric',

            'status'=>'required'


        ]);




        $orcamento = Orcamento::create($dados);



        return response()->json(

            $orcamento,

            201

        );


    }








    public function show($id)
    {


        return response()->json(

            Orcamento::with([

                'evento.cliente',
                'itens.servico',
                'pagamentos'

            ])
            ->findOrFail($id)

        );


    }








    public function update(Request $request,$id)
    {


        $orcamento = Orcamento::findOrFail($id);



        $orcamento->update(

            $request->all()

        );



        return response()->json(

            $orcamento

        );


    }








    public function destroy($id)
    {


        Orcamento::findOrFail($id)->delete();



        return response()->json([

            "message"=>"Orçamento removido"

        ]);

    }



}