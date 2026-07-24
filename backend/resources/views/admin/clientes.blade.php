@extends('admin.layout')


@section('title','Clientes')


@section('content')


<div class="header">

<h1>👥 Clientes</h1>

<p>
Cadastro de clientes dos eventos
</p>

</div>



<div class="table-box">


<h2>Novo Cliente</h2>


<form method="POST"
action="{{ route('admin.clientes.store') }}">


@csrf


<input 
name="nome"
placeholder="Nome completo"
required>


<input 
name="telefone"
placeholder="Telefone"
required>


<input 
name="email"
placeholder="Email">


<input 
name="cpf_cnpj"
placeholder="CPF/CNPJ">


<input 
name="endereco"
placeholder="Endereço">



<button class="btn">

Salvar Cliente

</button>


</form>


</div>


<br>



<div class="table-box">


<h2>Clientes cadastrados</h2>



<table>


<tr>

<th>ID</th>

<th>Nome</th>

<th>Telefone</th>

<th>Email</th>

<th>Ações</th>

</tr>



@foreach($clientes as $cliente)


<tr>


<td>
{{ $cliente->id }}
</td>


<td>
{{ $cliente->nome }}
</td>


<td>
{{ $cliente->telefone }}
</td>


<td>
{{ $cliente->email }}
</td>



<td>


<form method="POST"
action="{{ route('admin.clientes.delete',$cliente->id) }}">


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

gap:10px;

}


input{

padding:12px;

border-radius:8px;

border:1px solid #ccc;

}


button{

cursor:pointer;

border:none;

}



</style>



@endsection