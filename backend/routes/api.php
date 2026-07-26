<?php

use Illuminate\Support\Facades\Route;


/*
|--------------------------------------------------------------------------
| Controllers
|--------------------------------------------------------------------------
*/


use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\UsuarioController;

use App\Http\Controllers\Api\ClienteController;
use App\Http\Controllers\Api\EventoController;
use App\Http\Controllers\Api\CategoriaServicoController;
use App\Http\Controllers\Api\ServicoController;
use App\Http\Controllers\Api\OrcamentoController;
use App\Http\Controllers\Api\OrcamentoServicoController;
use App\Http\Controllers\Api\PagamentoController;




/*
|--------------------------------------------------------------------------
| AUTENTICAÇÃO
|--------------------------------------------------------------------------
*/


Route::post('/login',
[AuthController::class,'login']);



Route::post('/register',
[AuthController::class,'register']);







/*
|--------------------------------------------------------------------------
| ROTAS PROTEGIDAS
|--------------------------------------------------------------------------
*/


Route::middleware('auth:sanctum')->group(function(){





/*
|--------------------------------------------------------------------------
| Usuário
|--------------------------------------------------------------------------
*/


Route::get('/usuario',function(){

    return auth()->user();

});





Route::put('/usuario',
[UsuarioController::class,'update']);





Route::post('/usuario/foto',
[UsuarioController::class,'foto']);






Route::post('/logout',
[AuthController::class,'logout']);








/*
|--------------------------------------------------------------------------
| Clientes
|--------------------------------------------------------------------------
*/


Route::apiResource(

'clientes',

ClienteController::class

);








/*
|--------------------------------------------------------------------------
| Eventos
|--------------------------------------------------------------------------
*/


Route::apiResource(

'eventos',

EventoController::class

);








/*
|--------------------------------------------------------------------------
| Categorias
|--------------------------------------------------------------------------
*/


Route::apiResource(

'categorias',

CategoriaServicoController::class

);








/*
|--------------------------------------------------------------------------
| Serviços
|--------------------------------------------------------------------------
*/


Route::apiResource(

'servicos',

ServicoController::class

);








/*
|--------------------------------------------------------------------------
| Orçamentos
|--------------------------------------------------------------------------
*/


Route::apiResource(

'orcamentos',

OrcamentoController::class

);








/*
|--------------------------------------------------------------------------
| Serviços do orçamento
|--------------------------------------------------------------------------
*/


Route::apiResource(

'orcamento-servicos',

OrcamentoServicoController::class

);








/*
|--------------------------------------------------------------------------
| Pagamentos
|--------------------------------------------------------------------------
*/


Route::apiResource(

'pagamentos',

PagamentoController::class

);






});