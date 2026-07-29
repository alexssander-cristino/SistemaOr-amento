<?php

namespace App\Http\Controllers;

use App\Models\Orcamento;
use Barryvdh\DomPDF\Facade\Pdf;


class AdminOrcamentoPdfController extends Controller
{


    public function gerar($id)
    {


        $orcamento = Orcamento::with([

            'evento.cliente',

            'evento.categoria',

            'evento.servicos'

        ])
        ->findOrFail($id);



        $total = 0;



        foreach($orcamento->evento->servicos as $servico)
        {

            $total += $servico->pivot->subtotal ?? 0;

        }



        $pdf = Pdf::loadView(

            'admin.pdf_orcamento',

            [

                'orcamento'=>$orcamento,

                'total'=>$total

            ]

        );



        return $pdf->stream(

            'orcamento_'.$orcamento->id.'.pdf'

        );


    }


}