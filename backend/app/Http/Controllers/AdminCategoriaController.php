<?php

namespace App\Http\Controllers;

use App\Models\CategoriaServico;
use Illuminate\Http\Request;

class AdminCategoriaController extends Controller
{

    public function index()
    {
        return view('admin.categorias', [

            'categorias' => CategoriaServico::all()

        ]);
    }


    public function store(Request $request)
    {

        $dados = $request->validate([

            'nome' => 'required|string|max:100'

        ]);


        CategoriaServico::create($dados);


        return redirect()
            ->route('admin.categorias')
            ->with('success','Categoria cadastrada com sucesso!');
    }



    public function destroy($id)
    {

        CategoriaServico::findOrFail($id)->delete();


        return redirect()
            ->route('admin.categorias');

    }

}