<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;


class OrcamentoServico extends Model
{


    protected $fillable = [

        'orcamento_id',

        'servico_id',

        'quantidade',

        'valor_unitario',

        'subtotal'

    ];







    public function orcamento()
    {

        return $this->belongsTo(

            Orcamento::class

        );

    }







    public function servico()
    {

        return $this->belongsTo(

            Servico::class

        );

    }


}