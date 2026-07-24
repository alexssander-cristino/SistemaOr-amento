<?php

use Illuminate\Support\Facades\Route;

use App\Http\Controllers\ClienteController;
use App\Http\Controllers\EventoController;
use App\Http\Controllers\CategoriaServicoController;
use App\Http\Controllers\ServicoController;
use App\Http\Controllers\OrcamentoController;
use App\Http\Controllers\OrcamentoServicoController;
use App\Http\Controllers\PagamentoController;


Route::apiResource('clientes', ClienteController::class);

Route::apiResource('eventos', EventoController::class);

Route::apiResource('categorias', CategoriaServicoController::class);

Route::apiResource('servicos', ServicoController::class);

Route::apiResource('orcamentos', OrcamentoController::class);

Route::apiResource('orcamento-servicos', OrcamentoServicoController::class);

Route::apiResource('pagamentos', PagamentoController::class);