<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;


class Servico extends Model
{

    use HasFactory;




    protected $fillable = [

        'nome',

        'descricao',

        'valor',

        'categoria_id'

    ];







    public function categoria()
    {

        return $this->belongsTo(

            CategoriaServico::class,

            'categoria_id'

        );

    }







    public function eventos()
    {

        return $this->hasMany(

            EventoServico::class,

            'servico_id'

        );

    }







    public function orcamentos()
    {

        return $this->hasMany(

            OrcamentoServico::class,

            'servico_id'

        );

    }


}