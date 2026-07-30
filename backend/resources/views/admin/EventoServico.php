<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;


class EventoServico extends Model
{

    use HasFactory;



    protected $table = 'evento_servicos';



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

            Evento::class,

            'evento_id'

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