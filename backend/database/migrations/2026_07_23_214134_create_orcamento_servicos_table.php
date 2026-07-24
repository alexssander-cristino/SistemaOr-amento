<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
   public function up(): void
{
    Schema::create('orcamento_servicos', function (Blueprint $table) {

        $table->id();

        $table->foreignId('orcamento_id')
              ->constrained()
              ->cascadeOnDelete();

        $table->foreignId('servico_id')
              ->constrained()
              ->cascadeOnDelete();

        $table->integer('quantidade');

        $table->decimal('valor_unitario',10,2);

        $table->decimal('subtotal',10,2);

        $table->timestamps();
    });
}
};
