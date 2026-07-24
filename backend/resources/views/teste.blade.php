<!DOCTYPE html>
<html lang="pt-br">

<head>

    <meta charset="UTF-8">

    <title>Teste do Sistema</title>

    <style>

        body{

            font-family: Arial;

            background:#f4f4f4;

            padding:30px;

        }

        h1{

            color:#333;

        }

        .card{

            background:white;

            margin-bottom:20px;

            padding:20px;

            border-radius:10px;

            box-shadow:0 0 10px rgba(0,0,0,.1);

        }

        table{

            width:100%;

            border-collapse:collapse;

        }

        th,td{

            border:1px solid #ccc;

            padding:8px;

        }

        th{

            background:#007bff;

            color:white;

        }

    </style>

</head>

<body>

<h1>Sistema de Eventos</h1>

<div class="card">

<h2>Clientes</h2>

<table>

<tr>

<th>ID</th>
<th>Nome</th>
<th>Telefone</th>

</tr>

@foreach($clientes as $cliente)

<tr>

<td>{{ $cliente->id }}</td>
<td>{{ $cliente->nome }}</td>
<td>{{ $cliente->telefone }}</td>

</tr>

@endforeach

</table>

</div>

<div class="card">

<h2>Eventos</h2>

<table>

<tr>

<th>ID</th>
<th>Tipo</th>
<th>Local</th>

</tr>

@foreach($eventos as $evento)

<tr>

<td>{{ $evento->id }}</td>
<td>{{ $evento->tipo }}</td>
<td>{{ $evento->local }}</td>

</tr>

@endforeach

</table>

</div>

<div class="card">

<h2>Categorias</h2>

<table>

<tr>

<th>ID</th>
<th>Nome</th>

</tr>

@foreach($categorias as $categoria)

<tr>

<td>{{ $categoria->id }}</td>
<td>{{ $categoria->nome }}</td>

</tr>

@endforeach

</table>

</div>

<div class="card">

<h2>Serviços</h2>

<table>

<tr>

<th>ID</th>
<th>Nome</th>
<th>Valor</th>

</tr>

@foreach($servicos as $servico)

<tr>

<td>{{ $servico->id }}</td>
<td>{{ $servico->nome }}</td>
<td>R$ {{ number_format($servico->valor,2,',','.') }}</td>

</tr>

@endforeach

</table>

</div>

<div class="card">

<h2>Orçamentos</h2>

<table>

<tr>

<th>ID</th>
<th>Status</th>
<th>Total</th>

</tr>

@foreach($orcamentos as $orcamento)

<tr>

<td>{{ $orcamento->id }}</td>
<td>{{ $orcamento->status }}</td>
<td>R$ {{ number_format($orcamento->valor_total,2,',','.') }}</td>

</tr>

@endforeach

</table>

</div>

<div class="card">

<h2>Pagamentos</h2>

<table>

<tr>

<th>ID</th>
<th>Forma</th>
<th>Status</th>
<th>Valor</th>

</tr>

@foreach($pagamentos as $pagamento)

<tr>

<td>{{ $pagamento->id }}</td>
<td>{{ $pagamento->forma_pagamento }}</td>
<td>{{ $pagamento->status }}</td>
<td>R$ {{ number_format($pagamento->valor,2,',','.') }}</td>

</tr>

@endforeach

</table>

</div>

</body>

</html>