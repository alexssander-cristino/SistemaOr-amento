@extends('admin.layout')


@section('title','Eventos')


@section('content')



<div class="header">

<h1>
📅 Agenda de Eventos
</h1>


<p>
Controle de datas, clientes e serviços contratados
</p>


</div>






<div class="table-box">

<div id="calendar"></div>

</div>









<div class="table-box">


<h2>
➕ Novo Evento
</h2>



<form method="POST"
action="{{ route('admin.eventos.store') }}">


@csrf





<label>
Cliente
</label>


<select name="cliente_id" required>


<option value="">
Selecione
</option>



@foreach($clientes as $cliente)


<option value="{{ $cliente->id }}">

{{ $cliente->nome }}

</option>


@endforeach


</select>








<label>
Tipo de evento
</label>



<select name="categoria_evento_id" required>


<option value="">
Selecione
</option>



@foreach($categorias as $categoria)


<option value="{{ $categoria->id }}">

{{ $categoria->nome }}

</option>


@endforeach


</select>









<label>
Data
</label>


<input type="date"
name="data"
required>






<label>
Hora
</label>


<input type="time"
name="hora"
required>







<label>
Local
</label>


<input type="text"
name="local"
required>








<label>
Quantidade convidados
</label>


<input type="number"
name="quantidade_convidados"
min="1"
required>









<h3>
Serviços
</h3>





<div class="servicos">


@foreach($servicos as $servico)


<div class="card">



<input

type="checkbox"

name="servicos[]"

value="{{ $servico->id }}"

>



<b>
{{ $servico->nome }}
</b>



<br>


Categoria:

{{ optional($servico->categoria)->nome }}



<br>


Valor:

R$

{{ number_format(
$servico->valor,
2,
',',
'.'
) }}






<br><br>



Quantidade:



<input

type="number"

name="quantidades[{{ $servico->id }}]"

value="1"

min="1"

style="width:70px"

>




</div>



@endforeach


</div>









<label>
Observações
</label>


<textarea name="observacoes"></textarea>







<button class="btn">

💾 Salvar Evento

</button>






</form>


</div>









<style>


.table-box{

background:white;

padding:25px;

border-radius:15px;

margin-bottom:20px;

}



form{

display:grid;

gap:15px;

}



input,
select,
textarea{

padding:12px;

border-radius:8px;

border:1px solid #ccc;

}



.servicos{

display:grid;

grid-template-columns:
repeat(auto-fit,minmax(250px,1fr));

gap:15px;

}



.card{

background:#f5f5f5;

padding:15px;

border-radius:10px;

}



.btn{

background:#2ecc71;

color:white;

border:none;

padding:12px;

border-radius:10px;

}



</style>







@endsection