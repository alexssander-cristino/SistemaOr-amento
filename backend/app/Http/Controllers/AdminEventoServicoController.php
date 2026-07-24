<?php

namespace App\Http\Controllers;


use App\Models\Evento;
use App\Models\Servico;
use App\Models\EventoServico;
use Illuminate\Http\Request;


class AdminEventoServicoController extends Controller
{


public function index($evento_id)
{


$evento = Evento::with([
    'cliente',
    'servicos.servico'
])
->findOrFail($evento_id);



$servicos = Servico::all();



return view(
'admin.evento_servicos',
compact(
'evento',
'servicos'
)
);


}




public function store(Request $request,$evento_id)
{


$servico = Servico::findOrFail(
$request->servico_id
);



EventoServico::create([


'evento_id'=>$evento_id,


'servico_id'=>$servico->id,


'quantidade'=>$request->quantidade,


'valor_unitario'=>$servico->valor,


'subtotal'=>
$servico->valor * $request->quantidade


]);



return back();

}


}