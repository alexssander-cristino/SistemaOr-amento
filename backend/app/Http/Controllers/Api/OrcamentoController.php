<?php

namespace App\Http\Controllers\Api;


use App\Http\Controllers\Controller;

use App\Models\Orcamento;

use App\Models\Evento;

use Illuminate\Http\Request;





class OrcamentoController extends Controller
{





public function index()
{


return Orcamento::with([


'evento.cliente',

'servicos'


])

->get();



}









public function store(Request $request)
{


$request->validate([


'evento_id'=>'required'


]);






$evento =
Evento::with('servicos')

->findOrFail(

$request->evento_id

);







$total=0;



foreach($evento->servicos as $servico){


$total += $servico->valor;


}







$orcamento =
Orcamento::create([


'evento_id'=>$evento->id,

'valor_total'=>$total,

'status'=>'pendente'


]);







$orcamento->servicos()->attach(


$evento->servicos

->pluck('id')

);







return response()->json([


'message'=>'Orçamento criado',


'orcamento'=>

$orcamento->load([


'evento.cliente',

'servicos'


])



],201);




}









public function show($id)
{


return Orcamento::with([


'evento.cliente',

'evento',

'servicos'


])

->findOrFail($id);



}








public function destroy($id)
{


$orcamento =

Orcamento::findOrFail($id);



$orcamento->servicos()->detach();



$orcamento->delete();



return response()->json([

'message'=>'Excluído'

]);



}





}
