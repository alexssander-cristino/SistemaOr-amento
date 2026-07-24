<?php

namespace App\Http\Controllers;

use App\Models\Cliente;
use App\Models\Servico;
use App\Models\Evento;
use App\Models\Orcamento;

class AdminController extends Controller
{

    public function index()
    {
        return view('admin.dashboard', [

            'clientes' => Cliente::count(),

            'eventos' => Evento::count(),

            'servicos' => Servico::count(),

            'orcamentos' => Orcamento::count()

        ]);
    }


    public function clientes()
    {
        return view('admin.clientes', [

            'clientes'=>Cliente::all()

        ]);
    }


    public function servicos()
    {
        return view('admin.servicos', [

            'servicos'=>Servico::all()

        ]);
    }

}