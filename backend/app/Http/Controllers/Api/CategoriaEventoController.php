<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\CategoriaEvento;
use Illuminate\Http\Request;


class CategoriaEventoController extends Controller
{


    public function index()
    {

        return response()->json(
            CategoriaEvento::all()
        );

    }





    public function store(Request $request)
    {

        $request->validate([

            'nome'=>'required'

        ]);



        $categoria = CategoriaEvento::create([

            'nome'=>$request->nome

        ]);



        return response()->json(
            $categoria,
            201
        );

    }





    public function update(Request $request, $id)
    {

        $categoria =
            CategoriaEvento::findOrFail($id);


        $categoria->update([

            'nome'=>$request->nome

        ]);


        return response()->json(
            $categoria
        );

    }





    public function destroy($id)
    {

        CategoriaEvento::findOrFail($id)
            ->delete();


        return response()->json([

            'message'=>'Categoria removida'

        ]);

    }


}