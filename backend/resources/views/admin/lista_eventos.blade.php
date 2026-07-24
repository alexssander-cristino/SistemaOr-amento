@extends('admin.layout')


@section('title','Eventos')


@section('content')


<div class="header">

<h1>
📅 Eventos Cadastrados
</h1>

<p>
Visualização dos eventos agendados
</p>

</div>




<div class="table-box">


<table>


<tr>

<th>ID</th>

<th>Cliente</th>

<th>Evento</th>

<th>Data</th>

<th>Hora</th>

<th>Local</th>

<th>Convidados</th>

<th>Ação</th>

</tr>




@foreach($eventos as $evento)


<tr>


<td>
{{ $evento->id }}
</td>


<td>
{{ $evento->cliente->nome }}
</td>



<td>

{{ $evento->categoria->nome ?? 'Sem categoria' }}

</td>



<td>

{{ \Carbon\Carbon::parse($evento->data)->format('d/m/Y') }}

</td>



<td>

{{ $evento->hora }}

</td>



<td>

{{ $evento->local }}

</td>



<td>

{{ $evento->quantidade_convidados }}

</td>



<td>


<form method="POST"
action="{{ route('admin.lista_eventos.delete',$evento->id) }}">


@csrf

@method('DELETE')


<button class="btn-delete">

Excluir

</button>


</form>


</td>



</tr>


@endforeach



</table>


</div>




<style>


table{

width:100%;

border-collapse:collapse;

background:white;

border-radius:15px;

overflow:hidden;

}



th{

padding:15px;

background:#f1f1f1;

}



td{

padding:15px;

border-bottom:1px solid #ddd;

}



.btn-delete{

background:#e74c3c;

color:white;

padding:8px 15px;

border-radius:8px;

border:none;

cursor:pointer;

}


</style>



@endsection