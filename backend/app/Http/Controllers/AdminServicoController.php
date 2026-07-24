<?php

namespace App\Http\Controllers;

use App\Models\Servico;
use App\Models\CategoriaServico;
use Illuminate\Http\Request;

class AdminServicoController extends Controller
{

    public function index()
    {
        return view('admin.servicos', [

            'servicos' => Servico::with('categoria')->get(),

            'categorias' => CategoriaServico::all()

        ]);
    }


    public function store(Request $request)
    {

        $dados = $request->validate([

            'categoria_id' => 'required|exists:categorias_servicos,id',
            'nome' => 'required|string|max:100',
            'descricao' => 'nullable|string',
            'valor' => 'required|numeric'

        ]);


        Servico::create($dados);


        return redirect()
            ->route('admin.servicos')
            ->with('success','Serviço cadastrado com sucesso!');
    }



    public function destroy($id)
    {

        Servico::findOrFail($id)->delete();


        return redirect()
            ->route('admin.servicos');

    }

}