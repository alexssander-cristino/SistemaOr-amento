@extends('admin.layout')


@section('title','Categorias')


@section('content')


<div class="header">

<h1>
📂 Categorias de Serviços
</h1>

<p>
Organize os tipos de serviços oferecidos
</p>

</div>



<div class="table-box">


<h2>
Nova Categoria
</h2>


<form method="POST"
action="{{ route('admin.categorias.store') }}">


@csrf


<input 
type="text"
name="nome"
placeholder="Ex: Buffet"
required>


<button class="btn">

Salvar Categoria

</button>


</form>


</div>



<br>



<div class="table-box">


<h2>
Categorias cadastradas
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
action="{{ route('admin.categorias.delete',$categoria->id) }}">


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

border:none;

cursor:pointer;

}



</style>



@endsection