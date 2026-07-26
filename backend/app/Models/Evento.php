<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Evento extends Model
{


protected $fillable = [

    'cliente_id',
    'tipo',
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






public function servicos()
{

return $this->belongsToMany(

    Servico::class,

    'evento_servicos'

);

}






public function orcamento()
{

return $this->hasOne(
    Orcamento::class
);

}



}