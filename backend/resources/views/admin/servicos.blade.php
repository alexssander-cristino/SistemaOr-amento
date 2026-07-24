@extends('admin.layout')


@section('title','Serviços')


@section('content')


<div class="header">

<h1>📦 Serviços</h1>

<p>
Cadastro dos serviços oferecidos nos eventos
</p>

</div>



<div class="table-box">


<h2>Novo Serviço</h2>


<form method="POST"
action="{{ route('admin.servicos.store') }}">


@csrf



<label>
Categoria
</label>


<select name="categoria_id">


@foreach($categorias as $categoria)

<option value="{{ $categoria->id }}">

{{ $categoria->nome }}

</option>


@endforeach


</select>



<label>
Nome do serviço
</label>


<input 
type="text"
name="nome"
placeholder="Ex: Buffet completo"
required>



<label>
Descrição
</label>


<textarea 
name="descricao"
placeholder="Descrição do serviço">
</textarea>



<label>
Valor
</label>


<input 
type="number"
step="0.01"
name="valor"
placeholder="0.00"
required>



<button class="btn">

Salvar Serviço

</button>



</form>


</div>



<br>



<div class="table-box">


<h2>
Serviços cadastrados
</h2>



<table>


<tr>

<th>ID</th>

<th>Categoria</th>

<th>Nome</th>

<th>Valor</th>

<th>Ação</th>

</tr>



@foreach($servicos as $servico)


<tr>


<td>

{{ $servico->id }}

</td>


<td>

{{ $servico->categoria->nome ?? 'Sem categoria' }}

</td>


<td>

{{ $servico->nome }}

</td>


<td>

R$ {{ number_format($servico->valor,2,',','.') }}

</td>


<td>


<form method="POST"
action="{{ route('admin.servicos.delete',$servico->id) }}">


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

display:grid;

gap:12px;

}


input,select,textarea{

padding:12px;

border-radius:8px;

border:1px solid #ccc;

}


textarea{

height:100px;

}


button{

border:none;

cursor:pointer;

}


</style>



@endsection