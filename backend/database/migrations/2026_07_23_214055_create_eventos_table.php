<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
{
    Schema::create('eventos', function (Blueprint $table) {

        $table->id();

        $table->foreignId('cliente_id')
              ->constrained()
              ->cascadeOnDelete();

        $table->string('tipo');
        $table->date('data');
        $table->time('hora');

        $table->string('local');

        $table->integer('quantidade_convidados');

        $table->text('observacoes')->nullable();

        $table->timestamps();
    });
}
};
