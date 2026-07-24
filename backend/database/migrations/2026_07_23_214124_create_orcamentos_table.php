<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
   public function up(): void
{
    Schema::create('orcamentos', function (Blueprint $table) {

        $table->id();

        $table->foreignId('evento_id')
              ->constrained()
              ->cascadeOnDelete();

        $table->decimal('desconto',10,2)->default(0);

        $table->decimal('valor_total',10,2);

        $table->enum('status',[
            'Pendente',
            'Aprovado',
            'Recusado'
        ])->default('Pendente');

        $table->timestamps();
    });
}
};
