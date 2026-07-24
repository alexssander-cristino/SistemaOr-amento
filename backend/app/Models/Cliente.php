<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Cliente extends Model
{
    use HasFactory;

    protected $table = 'clientes';

    protected $fillable = [
        'nome',
        'telefone',
        'email',
        'cpf_cnpj',
        'endereco'
    ];

    public function eventos()
    {
        return $this->hasMany(Evento::class);
    }
}