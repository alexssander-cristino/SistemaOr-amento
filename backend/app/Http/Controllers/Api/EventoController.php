<?php

namespace App\Http\Controllers\Api;


use App\Http\Controllers\Controller;

use App\Models\Evento;

use Illuminate\Http\Request;





class EventoController extends Controller
{





public function index()
{


return Evento::with([

'cliente',

'servicos'

])

->get();


}









public function store(Request $request)
{


$request->validate([


'cliente_id'=>'required',

'tipo'=>'required',

'data'=>'required',

'servicos'=>'array'


]);







$evento = Evento::create([


'cliente_id'=>$request->cliente_id,

'tipo'=>$request->tipo,

'data'=>$request->data,

'hora'=>$request->hora,

'local'=>$request->local,

'quantidade_convidados'=>
$request->quantidade_convidados ?? 0,

'observacoes'=>$request->observacoes


]);








if($request->servicos){


$evento->servicos()->attach(

$request->servicos

);


}






return response()->json([


'message'=>'Evento criado',

'evento'=>$evento->load(

[
'cliente',
'servicos'
]

)



],201);



}









public function show($id)
{


return Evento::with([

'cliente',

'servicos'

])

->findOrFail($id);



}









public function destroy($id)
{


$evento =
Evento::findOrFail($id);



$evento->servicos()->detach();



$evento->delete();



return response()->json([

'message'=>'Removido'

]);



}





}