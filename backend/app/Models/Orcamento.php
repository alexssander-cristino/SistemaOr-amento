<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;



class Orcamento extends Model
{



protected $fillable=[


'evento_id',

'valor_total',

'status',

'desconto'


];






public function evento()
{


return $this->belongsTo(

Evento::class

);


}






public function servicos()
{


return $this->belongsToMany(

Servico::class,

'orcamento_servicos'

);



}





}