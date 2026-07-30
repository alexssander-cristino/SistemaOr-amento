<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\CategoriaEvento;


class CategoriaEventoController extends Controller
{


    public function index()
    {

        return response()->json(

            CategoriaEvento::orderBy('nome')->get()

        );

    }


}