<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{

    public function up(): void
    {
        Schema::table('eventos', function (Blueprint $table) {

            $table->foreignId('categoria_evento_id')
                  ->after('cliente_id')
                  ->constrained('categorias_eventos');

        });
    }


    public function down(): void
    {
        Schema::table('eventos', function (Blueprint $table) {

            $table->dropForeign([
                'categoria_evento_id'
            ]);

            $table->dropColumn('categoria_evento_id');

        });
    }

};