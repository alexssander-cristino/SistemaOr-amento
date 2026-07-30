<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;


class Orcamento extends Model
{


    protected $fillable = [

        'evento_id',
        'desconto',
        'valor_total',
        'status'

    ];






    public function evento()
    {

        return $this->belongsTo(

            Evento::class

        );

    }








    public function itens()
    {

        return $this->hasMany(

            OrcamentoServico::class,

            'orcamento_id'

        );

    }




    public function pagamentos()
    {

        return $this->hasMany(

            Pagamento::class

        );

    }



}