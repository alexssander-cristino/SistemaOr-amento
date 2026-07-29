<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class EventoServico extends Model
{


    protected $fillable = [

        'evento_id',
        'servico_id',
        'quantidade',
        'valor_unitario',
        'subtotal'

    ];





    public function evento()
    {

        return $this->belongsTo(
            Evento::class
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