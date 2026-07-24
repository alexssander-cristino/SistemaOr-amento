<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
{
    DB::statement("
        ALTER TABLE orcamentos
        DROP CONSTRAINT orcamentos_status_check
    ");


    DB::statement("
        ALTER TABLE orcamentos
        ADD CONSTRAINT orcamentos_status_check
        CHECK (
            status IN (
                'pendente',
                'aprovado',
                'recusado',
                'finalizado',
                'cancelado'
            )
        )
    ");
}
};
