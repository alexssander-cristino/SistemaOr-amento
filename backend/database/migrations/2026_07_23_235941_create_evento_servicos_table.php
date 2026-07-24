<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
   public function up()
{

    Schema::create('evento_servicos', function (Blueprint $table) {


        $table->id();


        $table->foreignId('evento_id')
        ->constrained()
        ->cascadeOnDelete();


        $table->foreignId('servico_id')
        ->constrained()
        ->cascadeOnDelete();



        $table->integer('quantidade')
        ->default(1);



        $table->decimal('valor_unitario',10,2);



        $table->decimal('subtotal',10,2);



        $table->timestamps();


    });

}
};
