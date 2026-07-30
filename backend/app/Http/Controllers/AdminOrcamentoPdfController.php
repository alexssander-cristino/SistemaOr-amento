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

            'itens.servico'


        ])

        ->findOrFail($id);






        $total = 0;





        foreach($orcamento->itens as $item)
        {


            $total += $item->subtotal;


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