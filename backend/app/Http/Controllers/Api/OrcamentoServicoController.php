<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\OrcamentoServico;
use Illuminate\Http\Request;

class OrcamentoServicoController extends Controller
{


public function index()
{

return response()->json(

OrcamentoServico::with('servico')
->get()

);

}



public function store(Request $request)
{

$item = OrcamentoServico::create(
$request->all()
);


return response()->json($item,201);

}



public function show($id)
{

return response()->json(
OrcamentoServico::findOrFail($id)
);

}



public function update(Request $request,$id)
{

$item = OrcamentoServico::findOrFail($id);


$item->update(
$request->all()
);


return response()->json($item);

}



public function destroy($id)
{

OrcamentoServico::destroy($id);


return response()->json([
"message"=>"Item removido"
]);

}


}