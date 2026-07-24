<?php

use Illuminate\Support\Facades\Route;

use App\Models\Cliente;
use App\Models\Evento;
use App\Models\Servico;
use App\Models\CategoriaServico;
use App\Models\Orcamento;
use App\Models\Pagamento;

use App\Http\Controllers\AdminController;
use App\Http\Controllers\AdminEventoController;
use App\Http\Controllers\AdminClienteController;
use App\Http\Controllers\AdminServicoController;
use App\Http\Controllers\AdminCategoriaController;
use App\Http\Controllers\AdminCategoriaEventoController;
use App\Http\Controllers\AdminListaEventosController;
use App\Http\Controllers\AdminOrcamentoController;
use App\Http\Controllers\AdminOrcamentoPdfController;


/*
|--------------------------------------------------------------------------
| Teste do banco
|--------------------------------------------------------------------------
*/

Route::get('/teste', function () {

    return view('teste', [
        'clientes' => Cliente::all(),
        'eventos' => Evento::all(),
        'categorias' => CategoriaServico::all(),
        'servicos' => Servico::all(),
        'orcamentos' => Orcamento::all(),
        'pagamentos' => Pagamento::all(),
    ]);

});


/*
|--------------------------------------------------------------------------
| Administração
|--------------------------------------------------------------------------
*/

Route::get('/admin', [AdminController::class, 'index'])
    ->name('admin');


Route::get('/admin/clientes', [AdminController::class, 'clientes'])
    ->name('admin.clientes');


Route::get('/admin/servicos', [AdminController::class, 'servicos'])
    ->name('admin.servicos');



/*
|--------------------------------------------------------------------------
| Eventos
|--------------------------------------------------------------------------
*/

Route::get('/admin/eventos', [AdminEventoController::class, 'index'])
    ->name('admin.eventos');


Route::post('/admin/eventos', [AdminEventoController::class, 'store'])
    ->name('admin.eventos.store');



/*
|--------------------------------------------------------------------------
| Clientes
|--------------------------------------------------------------------------
*/ 

Route::get('/admin/clientes',
[AdminClienteController::class,'index'])
->name('admin.clientes');


Route::post('/admin/clientes',
[AdminClienteController::class,'store'])
->name('admin.clientes.store');


Route::delete('/admin/clientes/{id}',
[AdminClienteController::class,'destroy'])
->name('admin.clientes.delete');



/*
|--------------------------------------------------------------------------
| Serviços
|--------------------------------------------------------------------------
*/

Route::get('/admin/servicos',
[AdminServicoController::class,'index'])
->name('admin.servicos');


Route::post('/admin/servicos',
[AdminServicoController::class,'store'])
->name('admin.servicos.store');


Route::delete('/admin/servicos/{id}',
[AdminServicoController::class,'destroy'])
->name('admin.servicos.delete');


/*
|--------------------------------------------------------------------------
| Categorias
|--------------------------------------------------------------------------
*/

Route::get('/admin/categorias',
[AdminCategoriaController::class,'index'])
->name('admin.categorias');


Route::post('/admin/categorias',
[AdminCategoriaController::class,'store'])
->name('admin.categorias.store');


Route::delete('/admin/categorias/{id}',
[AdminCategoriaController::class,'destroy'])
->name('admin.categorias.delete');



/*
|--------------------------------------------------------------------------
| Tipo evento
|--------------------------------------------------------------------------
*/

Route::get('/admin/categorias-eventos',
[AdminCategoriaEventoController::class,'index'])
->name('admin.categorias_eventos');


Route::post('/admin/categorias-eventos',
[AdminCategoriaEventoController::class,'store'])
->name('admin.categorias_eventos.store');


Route::delete('/admin/categorias-eventos/{id}',
[AdminCategoriaEventoController::class,'destroy'])
->name('admin.categorias_eventos.delete');



/*
|--------------------------------------------------------------------------
| Lista eventos
|--------------------------------------------------------------------------
*/

Route::get('/admin/eventos/lista',
[AdminListaEventosController::class,'index'])
->name('admin.lista_eventos');


Route::delete('/admin/eventos/lista/{id}',
[AdminListaEventosController::class,'destroy'])
->name('admin.lista_eventos.delete');


/*
|--------------------------------------------------------------------------
| Orçamentos
|--------------------------------------------------------------------------
*/

Route::get('/admin/orcamentos',
[AdminOrcamentoController::class,'index'])
->name('admin.orcamentos');


Route::post('/admin/orcamentos',
[AdminOrcamentoController::class,'store'])
->name('admin.orcamentos.store');


Route::delete('/admin/orcamentos/{id}',
[AdminOrcamentoController::class,'destroy'])
->name('admin.orcamentos.destroy');


/*
|--------------------------------------------------------------------------
| PDF
|--------------------------------------------------------------------------
*/

Route::get(
'/admin/orcamentos/{id}/pdf',
[AdminOrcamentoPdfController::class,'gerar']
)
->name('admin.orcamentos.pdf');