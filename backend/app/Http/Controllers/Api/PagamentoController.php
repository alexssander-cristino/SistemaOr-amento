<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Pagamento;
use Illuminate\Http\Request;

class PagamentoController extends Controller
{


public function index()
{

return response()->json(
Pagamento::with('orcamento')->get()
);

}



public function store(Request $request)
{

$pagamento = Pagamento::create(
$request->all()
);


return response()->json($pagamento,201);

}



public function show($id)
{

return response()->json(
Pagamento::findOrFail($id)
);

}



public function update(Request $request,$id)
{

$pagamento = Pagamento::findOrFail($id);


$pagamento->update(
$request->all()
);


return response()->json($pagamento);

}



public function destroy($id)
{

Pagamento::destroy($id);


return response()->json([
"message"=>"Pagamento removido"
]);

}


}