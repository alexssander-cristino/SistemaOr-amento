@extends('admin.layout')


@section('title','Orçamentos')


@section('content')


<div class="header">

<h1>
💰 Orçamentos
</h1>

<p>
Geração de orçamento baseado nos serviços contratados no evento
</p>

</div>





<div class="table-box">


<h2>
➕ Novo Orçamento
</h2>



<form method="POST"
action="{{ route('admin.orcamentos.store') }}">


@csrf



<label>
Evento
</label>


<select name="evento_id" required>


<option value="">
Selecione o evento
</option>



@foreach($eventos as $evento)


<option value="{{ $evento->id }}">


{{ optional($evento->categoria)->nome ?? 'Evento' }}

-

{{ optional($evento->cliente)->nome ?? 'Cliente' }}

-

{{ date('d/m/Y', strtotime($evento->data)) }}


</option>


@endforeach



</select>





<div class="info">


ℹ️ Os serviços utilizados no orçamento são os serviços cadastrados no evento.


</div>





<button class="btn">

💾 Gerar Orçamento

</button>



</form>


</div>








<br>








<div class="table-box">


<h2>
📋 Orçamentos Criados
</h2>





<table>


<thead>

<tr>

<th>
Cliente
</th>


<th>
Evento
</th>


<th>
Data
</th>


<th>
Serviços
</th>


<th>
Valor Total
</th>


<th>
Status
</th>


<th>
Ações
</th>


</tr>


</thead>





<tbody>



@forelse($orcamentos as $orcamento)



<tr>



<td>

{{ optional($orcamento->evento->cliente)->nome ?? 'Cliente removido' }}

</td>





<td>

{{ optional($orcamento->evento->categoria)->nome ?? 'Evento' }}

</td>





<td>

{{ date(
'd/m/Y',
strtotime($orcamento->evento->data)
) }}

</td>







<td>


@if($orcamento->itens->count())


<ul>


@foreach($orcamento->itens as $item)


<li>


{{ optional($item->servico)->nome ?? 'Serviço removido' }}


</li>


@endforeach


</ul>



@else


Nenhum serviço


@endif



</td>







<td>


R$

{{ number_format(
$orcamento->valor_total,
2,
',',
'.'
) }}



</td>






<td>


<span class="status">

{{ ucfirst($orcamento->status) }}

</span>


</td>








<td>



<a

href="{{ route(
'admin.orcamentos.pdf',
$orcamento->id
) }}"

class="btn-pdf"

>

📄 PDF

</a>







<form

method="POST"

action="{{ route(
'admin.orcamentos.destroy',
$orcamento->id
) }}"

class="delete-form"

>


@csrf

@method('DELETE')



<button

class="btn-delete"

onclick="return confirm('Excluir orçamento?')"

>

🗑️

</button>



</form>




</td>





</tr>





@empty


<tr>

<td colspan="7">

Nenhum orçamento criado.

</td>

</tr>



@endforelse




</tbody>


</table>


</div>







<style>


.table-box{

background:white;

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

font-size:16px;

}




.info{

background:#ecf0f1;

padding:15px;

border-radius:10px;

}





.btn{


background:#2ecc71;

color:white;

border:none;

padding:12px 20px;

border-radius:10px;

font-size:16px;

cursor:pointer;


}





table{


width:100%;

border-collapse:collapse;


}




th{


background:#eee;

padding:15px;

text-align:left;


}




td{


padding:15px;

border-bottom:1px solid #ddd;


}





ul{


margin:0;

padding-left:20px;


}




.status{


background:#f1c40f;

padding:6px 12px;

border-radius:20px;


}






.btn-pdf{


background:#3498db;

color:white;

padding:8px 15px;

border-radius:8px;

text-decoration:none;


}





.delete-form{


display:inline;


}




.btn-delete{


background:#e74c3c;

color:white;

border:none;

padding:8px 12px;

border-radius:8px;

cursor:pointer;


}





</style>





@endsection