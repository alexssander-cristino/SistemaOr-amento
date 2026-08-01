<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Evento;
use App\Models\EventoServico;
use App\Models\Servico;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

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

            'quantidade_convidados' => 'required|integer|min:1',

            'observacoes' => 'nullable|string',

            'servicos' => 'nullable|array',

            'servicos.*.servico_id' => 'required|exists:servicos,id',

            'servicos.*.quantidade' => 'required|integer|min:1',

        ]);

        DB::beginTransaction();

        try {

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

                foreach ($dados['servicos'] as $item) {

                    $servico = Servico::findOrFail(
                        $item['servico_id']
                    );

                    $quantidade = (int) $item['quantidade'];

                    EventoServico::create([

                        'evento_id' => $evento->id,

                        'servico_id' => $servico->id,

                        'quantidade' => $quantidade,

                        'valor_unitario' => $servico->valor,

                        'subtotal' => $servico->valor * $quantidade,

                    ]);
                }
            }

            DB::commit();

            return response()->json(

                Evento::with([
                    'cliente',
                    'categoria',
                    'servicos'
                ])->find($evento->id),

                201

            );

        } catch (\Exception $e) {

            DB::rollBack();

            return response()->json([
                'message' => $e->getMessage()
            ], 500);

        }
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
        $dados = $request->validate([

            'cliente_id' => 'required|exists:clientes,id',

            'categoria_evento_id' => 'required|exists:categorias_eventos,id',

            'data' => 'required|date',

            'hora' => 'required',

            'local' => 'required',

            'quantidade_convidados' => 'required|integer|min:1',

            'observacoes' => 'nullable|string',

            'servicos' => 'nullable|array',

            'servicos.*.servico_id' => 'required|exists:servicos,id',

            'servicos.*.quantidade' => 'required|integer|min:1',

        ]);

        DB::beginTransaction();

        try {

            $evento = Evento::findOrFail($id);

            $evento->update([

                'cliente_id' => $dados['cliente_id'],

                'categoria_evento_id' => $dados['categoria_evento_id'],

                'data' => $dados['data'],

                'hora' => $dados['hora'],

                'local' => $dados['local'],

                'quantidade_convidados' => $dados['quantidade_convidados'],

                'observacoes' => $dados['observacoes'] ?? null,

            ]);

            EventoServico::where(
                'evento_id',
                $evento->id
            )->delete();

            if (!empty($dados['servicos'])) {

                foreach ($dados['servicos'] as $item) {

                    $servico = Servico::findOrFail(
                        $item['servico_id']
                    );

                    $quantidade = (int) $item['quantidade'];

                    EventoServico::create([

                        'evento_id' => $evento->id,

                        'servico_id' => $servico->id,

                        'quantidade' => $quantidade,

                        'valor_unitario' => $servico->valor,

                        'subtotal' => $servico->valor * $quantidade,

                    ]);
                }
            }

            DB::commit();

            return response()->json(

                Evento::with([
                    'cliente',
                    'categoria',
                    'servicos'
                ])->find($evento->id)

            );

        } catch (\Exception $e) {

            DB::rollBack();

            return response()->json([
                'message' => $e->getMessage()
            ], 500);

        }
    }

    public function destroy($id)
    {
        DB::beginTransaction();

        try {

            EventoServico::where(
                'evento_id',
                $id
            )->delete();

            Evento::destroy($id);

            DB::commit();

            return response()->json([
                'message' => 'Evento removido com sucesso.'
            ]);

        } catch (\Exception $e) {

            DB::rollBack();

            return response()->json([
                'message' => $e->getMessage()
            ], 500);

        }
    }
}