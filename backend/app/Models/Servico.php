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

        return $this->belongsToMany(

            Evento::class,

            'evento_servicos'

        )
        ->withPivot([

            'quantidade',
            'valor_unitario',
            'subtotal'

        ]);

    }





    public function orcamentos()
    {

        return $this->belongsToMany(

            Orcamento::class,

            'orcamento_servicos'

        );

    }


}