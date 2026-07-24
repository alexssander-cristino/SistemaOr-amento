<?php

namespace App\Http\Controllers;

use App\Models\Evento;

class AdminListaEventosController extends Controller
{

    public function index()
    {

        $eventos = Evento::with([
            'cliente',
            'categoria'
        ])
        ->orderBy('data','asc')
        ->get();


        return view('admin.lista_eventos', [

            'eventos' => $eventos

        ]);

    }



    public function destroy($id)
    {

        Evento::findOrFail($id)->delete();


        return redirect()

            ->route('admin.lista_eventos')

            ->with('success','Evento excluído!');

    }

}