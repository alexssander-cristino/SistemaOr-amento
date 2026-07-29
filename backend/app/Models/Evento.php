<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Evento extends Model
{


    protected $fillable = [

        'cliente_id',
        'categoria_evento_id',
        'data',
        'hora',
        'local',
        'quantidade_convidados',
        'observacoes'

    ];





    public function cliente()
    {

        return $this->belongsTo(
            Cliente::class
        );

    }






    public function categoria()
    {

        return $this->belongsTo(
            CategoriaEvento::class,
            'categoria_evento_id'
        );

    }







    public function servicos()
    {

        return $this->hasMany(
            EventoServico::class,
            'evento_id'
        );

    }







    public function orcamento()
    {

        return $this->hasOne(
            Orcamento::class
        );

    }



}