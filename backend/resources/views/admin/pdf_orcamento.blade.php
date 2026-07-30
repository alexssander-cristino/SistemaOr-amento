<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>
Orçamento
</title>


<style>

body{

font-family: Arial;

font-size:14px;

}


h1{

text-align:center;

}


h3{

margin-top:25px;

}


table{

width:100%;

border-collapse:collapse;

margin-top:20px;

}


th,td{

border:1px solid #ccc;

padding:10px;

}


th{

background:#eee;

}


.total{

font-size:18px;

font-weight:bold;

text-align:right;

margin-top:20px;

}


.info{

margin-bottom:5px;

}


</style>


</head>


<body>


<h1>
ORÇAMENTO DE EVENTO
</h1>


<hr>




<h3>
Dados do Cliente
</h3>


<p class="info">

<strong>
Nome:
</strong>

{{ optional($orcamento->evento->cliente)->nome ?? 'Cliente não encontrado' }}

</p>







<h3>
Evento
</h3>



<p class="info">

<strong>
Tipo:
</strong>

{{ optional($orcamento->evento->categoria)->nome ?? 'Evento' }}

</p>





<p class="info">

<strong>
Data:
</strong>

{{ date(
'd/m/Y',
strtotime($orcamento->evento->data)
) }}

</p>





<p class="info">

<strong>
Horário:
</strong>

{{ $orcamento->evento->hora }}

</p>





<p class="info">

<strong>
Local:
</strong>

{{ $orcamento->evento->local }}

</p>









<h3>
Serviços Contratados
</h3>





<table>


<tr>

<th>
Serviço
</th>


<th>
Quantidade
</th>


<th>
Valor Unitário
</th>


<th>
Subtotal
</th>


</tr>







@foreach($orcamento->itens as $item)



<tr>


<td>

{{ optional($item->servico)->nome ?? 'Serviço removido' }}

</td>





<td>

{{ $item->quantidade }}

</td>





<td>

R$

{{ number_format(
$item->valor_unitario,
2,
',',
'.'
) }}

</td>





<td>

R$

{{ number_format(
$item->subtotal,
2,
',',
'.'
) }}

</td>



</tr>



@endforeach







</table>






<br>





<p class="total">


Total:

R$

{{ number_format(
$orcamento->valor_total,
2,
',',
'.'
) }}



</p>






<p>

<strong>
Status:
</strong>

{{ ucfirst($orcamento->status) }}


</p>





</body>

</html>