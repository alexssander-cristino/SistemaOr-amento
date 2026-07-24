<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pagamento extends Model
{
    use HasFactory;

    protected $table = 'pagamentos';

    protected $fillable = [
        'orcamento_id',
        'forma_pagamento',
        'valor',
        'data_pagamento',
        'status'
    ];

    protected $casts = [
        'data_pagamento' => 'date',
        'valor' => 'decimal:2'
    ];

    public function orcamento()
    {
        return $this->belongsTo(Orcamento::class);
    }
}