<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\CategoriaServico;
use Illuminate\Http\Request;

class CategoriaServicoController extends Controller
{


public function index()
{

return response()->json(
CategoriaServico::all()
);

}



public function store(Request $request)
{

$categoria = CategoriaServico::create(
$request->all()
);


return response()->json($categoria,201);

}



public function show($id)
{

return response()->json(
CategoriaServico::findOrFail($id)
);

}



public function update(Request $request,$id)
{

$categoria = CategoriaServico::findOrFail($id);

$categoria->update(
$request->all()
);


return response()->json($categoria);

}



public function destroy($id)
{

CategoriaServico::destroy($id);


return response()->json([
"message"=>"Categoria removida"
]);

}


}