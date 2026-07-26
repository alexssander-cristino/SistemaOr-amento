<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;


class Servico extends Model
{


protected $fillable=[


'nome',

'descricao',

'valor',

'categoria_id'


];






public function categoria()
{


return $this->belongsTo(
CategoriaServico::class
);


}






public function eventos()
{


return $this->belongsToMany(

Evento::class,

'evento_servicos'

);


}






public function orcamentos()
{


return $this->belongsToMany(

Orcamento::class,

'orcamento_servicos'

);


}




}