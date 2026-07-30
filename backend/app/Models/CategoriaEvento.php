<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;


class CategoriaEvento extends Model
{

    use HasFactory;



    protected $table = 'categorias_eventos';



    protected $fillable = [

        'nome'

    ];





    public function eventos()
    {

        return $this->hasMany(
            Evento::class,
            'categoria_evento_id'
        );

    }


}