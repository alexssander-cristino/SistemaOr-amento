<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;


class Orcamento extends Model
{

    use HasFactory;


    protected $fillable = [

        'evento_id',
        'valor_total',
        'status',
        'desconto'

    ];





    public function evento()
    {

        return $this->belongsTo(
            Evento::class,
            'evento_id'
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
            Pagamento::class,
            'orcamento_id'
        );

    }



}