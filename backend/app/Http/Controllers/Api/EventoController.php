<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Evento;
use App\Models\EventoServico;
use App\Models\Servico;
use Illuminate\Http\Request;

class EventoController extends Controller
{

    public function index()
    {
        return response()->json(

            Evento::with([
                'cliente',
                'categoria',
                'servicos'
            ])
            ->orderBy('data')
            ->get()

        );
    }

    public function store(Request $request)
    {

        $dados = $request->validate([

            'cliente_id' => 'required|exists:clientes,id',

            'categoria_evento_id' => 'required|exists:categorias_eventos,id',

            'data' => 'required|date',

            'hora' => 'required',

            'local' => 'required',

            'quantidade_convidados' => 'required|integer',

            'observacoes' => 'nullable',

            'servicos' => 'nullable|array',

            'servicos.*' => 'exists:servicos,id'

        ]);


        $evento = Evento::create([

            'cliente_id' => $dados['cliente_id'],

            'categoria_evento_id' => $dados['categoria_evento_id'],

            'data' => $dados['data'],

            'hora' => $dados['hora'],

            'local' => $dados['local'],

            'quantidade_convidados' => $dados['quantidade_convidados'],

            'observacoes' => $dados['observacoes'] ?? null,

        ]);


        if (!empty($dados['servicos'])) {

            foreach ($dados['servicos'] as $id) {

                $servico = Servico::findOrFail($id);

                EventoServico::create([

                    'evento_id' => $evento->id,

                    'servico_id' => $servico->id,

                    'quantidade' => 1,

                    'valor_unitario' => $servico->valor,

                    'subtotal' => $servico->valor,

                ]);
            }
        }

        return response()->json(

            Evento::with([
                'cliente',
                'categoria',
                'servicos'
            ])->find($evento->id),

            201

        );
    }

    public function show($id)
    {
        return response()->json(

            Evento::with([
                'cliente',
                'categoria',
                'servicos'
            ])->findOrFail($id)

        );
    }

    public function update(Request $request, $id)
    {

        $evento = Evento::findOrFail($id);

        $evento->update($request->all());

        return response()->json(

            Evento::with([
                'cliente',
                'categoria',
                'servicos'
            ])->find($id)

        );
    }

    public function destroy($id)
    {

        EventoServico::where('evento_id', $id)->delete();

        Evento::destroy($id);

        return response()->json([
            'message' => 'Evento removido'
        ]);
    }

}