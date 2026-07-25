@extends('admin.layout')

@section('title','Orçamentos')

@section('content')

<div class="header">

    <h1>💰 Orçamentos</h1>

    <p>Geração de orçamento baseada nos serviços vinculados ao evento.</p>

</div>



@if(session('success'))

<div class="alert-success">
    {{ session('success') }}
</div>

@endif


@if(session('error'))

<div class="alert-error">
    {{ session('error') }}
</div>

@endif



<div class="table-box">

    <h2>➕ Novo Orçamento</h2>

    <form method="POST" action="{{ route('admin.orcamentos.store') }}">

        @csrf

        <label>Evento</label>

        <select name="evento_id" required>

            <option value="">Selecione um evento</option>

            @foreach($eventos as $evento)

                @if(!$evento->orcamento)

                <option value="{{ $evento->id }}">

                    {{ optional($evento->categoria)->nome }}

                    -

                    {{ optional($evento->cliente)->nome }}

                    -

                    {{ date('d/m/Y',strtotime($evento->data)) }}

                </option>

                @endif

            @endforeach

        </select>

        <div class="info">

            O orçamento utilizará automaticamente os serviços cadastrados neste evento.

        </div>

        <button class="btn">

            💾 Gerar Orçamento

        </button>

    </form>

</div>



<br>



<div class="table-box">

<h2>📋 Orçamentos Criados</h2>

<table>

<thead>

<tr>

<th>Cliente</th>
<th>Evento</th>
<th>Data</th>
<th>Serviços</th>
<th>Total</th>
<th>Status</th>
<th>Ações</th>

</tr>

</thead>

<tbody>

@forelse($orcamentos as $orcamento)

<tr>

<td>

{{ optional($orcamento->evento->cliente)->nome }}

</td>

<td>

{{ optional($orcamento->evento->categoria)->nome }}

</td>

<td>

{{ date('d/m/Y',strtotime($orcamento->evento->data)) }}

</td>

<td>

@if($orcamento->evento && $orcamento->evento->servicos->count())

<ul>

@foreach($orcamento->evento->servicos as $item)

<li>

{{ optional($item->servico)->nome }}

</li>

@endforeach

</ul>

@else

Nenhum serviço

@endif

</td>

<td>

R$ {{ number_format($orcamento->valor_total,2,',','.') }}

</td>

<td>

{{ ucfirst($orcamento->status) }}

</td>

<td>

<a
href="{{ route('admin.orcamentos.pdf',$orcamento->id) }}"
class="btn-pdf">

📄 PDF

</a>

<form
method="POST"
action="{{ route('admin.orcamentos.destroy',$orcamento->id) }}"
class="delete-form">

@csrf
@method('DELETE')

<button
class="btn-delete"
onclick="return confirm('Excluir orçamento?')">

🗑️

</button>

</form>

</td>

</tr>

@empty

<tr>

<td colspan="7">

Nenhum orçamento cadastrado.

</td>

</tr>

@endforelse

</tbody>

</table>

</div>



<style>

.table-box{

background:#fff;
padding:25px;
border-radius:15px;
margin-bottom:20px;

}

form{

display:flex;
flex-direction:column;
gap:15px;

}

select{

padding:12px;
border-radius:10px;
border:1px solid #ccc;

}

.info{

background:#eef4ff;
padding:15px;
border-radius:10px;

}

.alert-success{

background:#d4edda;
color:#155724;
padding:15px;
border-radius:10px;
margin-bottom:20px;

}

.alert-error{

background:#f8d7da;
color:#721c24;
padding:15px;
border-radius:10px;
margin-bottom:20px;

}

table{

width:100%;
border-collapse:collapse;

}

th{

background:#eee;
padding:12px;

}

td{

padding:12px;
border-bottom:1px solid #ddd;

}

.btn{

background:#2ecc71;
color:#fff;
border:none;
padding:12px;
border-radius:10px;
cursor:pointer;

}

.btn-pdf{

background:#3498db;
color:#fff;
padding:8px 15px;
text-decoration:none;
border-radius:8px;

}

.delete-form{

display:inline;

}

.btn-delete{

background:#e74c3c;
color:#fff;
border:none;
padding:8px 12px;
border-radius:8px;
cursor:pointer;

}

</style>

@endsection