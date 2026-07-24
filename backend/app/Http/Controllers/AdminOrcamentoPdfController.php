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

            'evento.servicos.servico'


        ])
        ->findOrFail($id);




        // Calcula o total pelos serviços do evento

        $total = 0;


        foreach($orcamento->evento->servicos as $item)
        {

            $total += $item->subtotal;

        }



        $orcamento->valor_total = $total;




        $pdf = Pdf::loadView(

            'admin.pdf_orcamento',

            compact('orcamento')

        );



        return $pdf->stream(

            'orcamento_'.$orcamento->id.'.pdf'

        );


    }


}