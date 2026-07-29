<?php

namespace App\Http\Controllers;


use App\Models\Evento;
use App\Models\Cliente;
use App\Models\CategoriaEvento;
use App\Models\Servico;
use App\Models\EventoServico;

use Illuminate\Http\Request;



class AdminEventoController extends Controller
{


    public function index()
    {


        return view('admin.eventos',[


            'eventos'=>Evento::with([

                'cliente',
                'categoria',
                'servicos.servico'

            ])
            ->orderBy('data')
            ->get(),



            'clientes'=>Cliente::all(),



            'categorias'=>CategoriaEvento::all(),



            'servicos'=>Servico::with('categoria')
                ->orderBy('nome')
                ->get()


        ]);


    }









    public function store(Request $request)
    {


        $request->validate([



            'cliente_id'=>[
                'required',
                'exists:clientes,id'
            ],



            'categoria_evento_id'=>[
                'required',
                'exists:categorias_eventos,id'
            ],



            'data'=>[
                'required',
                'date'
            ],



            'hora'=>[
                'required'
            ],



            'local'=>[
                'required',
                'string'
            ],



            'quantidade_convidados'=>[
                'required',
                'integer',
                'min:1'
            ],



            'observacoes'=>[
                'nullable',
                'string'
            ],



            'servicos'=>[
                'nullable',
                'array'
            ],



            'servicos.*'=>[
                'exists:servicos,id'
            ]



        ]);








        /*
        |--------------------------------------------------------------------------
        | Criar Evento
        |--------------------------------------------------------------------------
        */


        $evento = Evento::create([


            'cliente_id'=>$request->cliente_id,


            'categoria_evento_id'=>$request->categoria_evento_id,


            'data'=>$request->data,


            'hora'=>$request->hora,


            'local'=>$request->local,


            'quantidade_convidados'=>$request->quantidade_convidados,


            'observacoes'=>$request->observacoes


        ]);










        /*
        |--------------------------------------------------------------------------
        | Adicionar serviços do evento
        |--------------------------------------------------------------------------
        */


        if($request->filled('servicos'))
        {


            foreach($request->servicos as $id)
            {


                $servico = Servico::findOrFail($id);



                EventoServico::create([


                    'evento_id'=>$evento->id,


                    'servico_id'=>$servico->id,


                    'quantidade'=>1,


                    'valor_unitario'=>$servico->valor,


                    'subtotal'=>$servico->valor


                ]);



            }


        }










        return redirect()

            ->route('admin.eventos')

            ->with(

                'success',

                'Evento cadastrado com sucesso!'

            );


    }












    public function destroy($id)
    {


        $evento = Evento::findOrFail($id);




        /*
        |--------------------------------------------------------------------------
        | Remove serviços vinculados
        |--------------------------------------------------------------------------
        */


        EventoServico::where(

            'evento_id',

            $evento->id

        )->delete();






        /*
        |--------------------------------------------------------------------------
        | Remove evento
        |--------------------------------------------------------------------------
        */


        $evento->delete();







        return redirect()

            ->route('admin.eventos')

            ->with(

                'success',

                'Evento removido com sucesso!'

            );


    }



}