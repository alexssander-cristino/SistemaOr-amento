<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;


class OrcamentoServico extends Model
{

    use HasFactory;



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

            Orcamento::class,

            'orcamento_id'

        );

    }





    public function servico()
    {

        return $this->belongsTo(

            Servico::class,

            'servico_id'

        );

    }


}