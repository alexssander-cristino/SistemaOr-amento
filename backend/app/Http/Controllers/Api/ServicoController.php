<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Servico;
use Illuminate\Http\Request;

class ServicoController extends Controller
{


public function index()
{

return response()->json(

Servico::with('categoria')->get()

);

}



public function store(Request $request)
{

$servico = Servico::create(
$request->all()
);


return response()->json($servico,201);

}



public function show($id)
{

return response()->json(
Servico::with('categoria')
->findOrFail($id)
);

}



public function update(Request $request,$id)
{

$servico = Servico::findOrFail($id);


$servico->update(
$request->all()
);


return response()->json($servico);

}



public function destroy($id)
{

Servico::destroy($id);


return response()->json([
"message"=>"Serviço removido"
]);

}


}