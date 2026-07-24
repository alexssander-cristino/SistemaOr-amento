<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Servico extends Model
{
    use HasFactory;


    protected $fillable = [

        'categoria_id',
        'nome',
        'descricao',
        'valor'

    ];



    public function categoria()
    {
        return $this->belongsTo(
            CategoriaServico::class,
            'categoria_id'
        );
    }

}