@extends('admin.layout')


@section('title','Tipos de Evento')


@section('content')


<div class="header">

<h1>
🎉 Tipos de Evento
</h1>

<p>
Cadastre os tipos de eventos realizados
</p>

</div>



<div class="table-box">


<h2>
Novo Tipo de Evento
</h2>



<form method="POST"
action="{{ route('admin.categorias_eventos.store') }}">


@csrf


<input
type="text"
name="nome"
placeholder="Ex: Casamento"
required
>


<button class="btn">

Salvar

</button>


</form>


</div>



<br>



<div class="table-box">


<h2>
Tipos cadastrados
</h2>



<table>


<tr>

<th>ID</th>

<th>Nome</th>

<th>Ação</th>

</tr>



@foreach($categorias as $categoria)


<tr>


<td>

{{ $categoria->id }}

</td>


<td>

{{ $categoria->nome }}

</td>


<td>


<form method="POST"
action="{{ route('admin.categorias_eventos.delete',$categoria->id) }}">


@csrf

@method('DELETE')


<button>

Excluir

</button>


</form>


</td>


</tr>


@endforeach



</table>


</div>



<style>

form{

display:flex;

gap:10px;

}


input{

padding:12px;

border-radius:8px;

border:1px solid #ccc;

flex:1;

}


button{

cursor:pointer;

border:none;

}


</style>



@endsection