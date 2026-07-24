<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CategoriaServico extends Model
{
    use HasFactory;

    protected $table = 'categorias_servicos';

    protected $fillable = [
        'nome'
    ];

    public function servicos()
    {
        return $this->hasMany(Servico::class, 'categoria_id');
    }
}