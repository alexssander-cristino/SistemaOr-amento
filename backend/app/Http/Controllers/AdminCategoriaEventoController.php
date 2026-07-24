<?php

namespace App\Http\Controllers;

use App\Models\CategoriaEvento;
use Illuminate\Http\Request;

class AdminCategoriaEventoController extends Controller
{

    public function index()
    {

        return view('admin.categorias_eventos', [

            'categorias' => CategoriaEvento::all()

        ]);

    }



    public function store(Request $request)
    {

        $dados = $request->validate([

            'nome' => 'required|string|max:100'

        ]);


        CategoriaEvento::create($dados);


        return redirect()

            ->route('admin.categorias_eventos')

            ->with('success','Tipo de evento cadastrado!');

    }



    public function destroy($id)
    {

        CategoriaEvento::findOrFail($id)->delete();


        return redirect()

            ->route('admin.categorias_eventos')

            ->with('success','Tipo de evento removido!');

    }

}