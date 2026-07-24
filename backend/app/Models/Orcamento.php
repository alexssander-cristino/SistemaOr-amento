<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Orcamento extends Model
{
    use HasFactory;


    protected $fillable = [

        'evento_id',
        'desconto',
        'valor_total',
        'status'

    ];



    public function evento()
    {

        return $this->belongsTo(Evento::class);

    }



    public function itens()
    {

        return $this->hasMany(OrcamentoServico::class);

    }



    public function pagamentos()
    {

        return $this->hasMany(Pagamento::class);

    }



    // Soma os valores dos itens automaticamente
    public function calcularTotal()
    {

        return $this->itens->sum('subtotal');

    }

}