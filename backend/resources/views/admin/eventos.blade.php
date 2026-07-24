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



<form method="POST" action="{{ route('admin.eventos.store') }}">

@csrf



<label>
Cliente
</label>


<select name="cliente_id" required>

<option value="">
Selecione o cliente
</option>


@foreach($clientes as $cliente)

<option value="{{ $cliente->id }}">

{{ $cliente->nome }}

</option>

@endforeach


</select>






<label>
Tipo de Evento
</label>


<select name="categoria_evento_id" required>


<option value="">
Selecione o tipo
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


<input

type="date"

name="data"

required

>






<label>
Horário
</label>


<input

type="time"

name="hora"

required

>







<label>
Local
</label>


<input

type="text"

name="local"

placeholder="Local do evento"

required

>







<label>
Quantidade de convidados
</label>


<input

type="number"

name="quantidade_convidados"

min="1"

required

>








<label>
Serviços contratados
</label>



<div class="servicos">


@forelse($servicos as $servico)



<div class="servico-card">


<label class="check">


<input

type="checkbox"

name="servicos[]"

value="{{ $servico->id }}"

>


<div>


<strong>
{{ $servico->nome }}
</strong>


<br>


Categoria:

{{ optional($servico->categoria)->nome ?? 'Sem categoria' }}


<br>


Valor:

R$

{{ number_format(
$servico->valor,
2,
',',
'.'
) }}



</div>


</label>


</div>



@empty


<p>
Nenhum serviço cadastrado.
</p>


@endforelse



</div>







<label>
Observações
</label>


<textarea

name="observacoes"

placeholder="Detalhes do evento">

</textarea>







<button class="btn">

💾 Salvar Evento

</button>



</form>


</div>









<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>




<script>


document.addEventListener('DOMContentLoaded', function(){


let calendar = new FullCalendar.Calendar(

document.getElementById('calendar'),

{


initialView:'dayGridMonth',


locale:'pt-br',


height:600,



events:[



@foreach($eventos as $evento)


{


title:

"{{ optional($evento->categoria)->nome ?? 'Evento' }} - {{ optional($evento->cliente)->nome ?? 'Cliente' }}",


start:

"{{ $evento->data }}T{{ $evento->hora }}"


},


@endforeach



],




dateClick:function(info){


document.querySelector('[name=data]').value = info.dateStr;


window.scrollTo({

top:700,

behavior:'smooth'

});


}



}



);



calendar.render();



});



</script>









<style>


#calendar{


background:white;

padding:20px;

border-radius:15px;


}




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


width:100%;

padding:12px;

border-radius:8px;

border:1px solid #ccc;

font-size:15px;


}




textarea{


height:100px;

resize:none;


}







.servicos{


display:grid;

grid-template-columns:repeat(auto-fit,minmax(250px,1fr));

gap:15px;


}






.servico-card{


background:#f7f7f7;

border:1px solid #ddd;

border-radius:12px;

padding:15px;


}






.check{


display:flex;

align-items:flex-start;

gap:12px;

cursor:pointer;


}







.check input[type="checkbox"]{


width:20px !important;

height:20px !important;

margin-top:5px;

cursor:pointer;


}







.btn{


background:#2ecc71;

color:white;

border:none;

padding:12px 20px;

border-radius:10px;

cursor:pointer;

font-size:16px;


}



.btn:hover{


opacity:0.8;


}



</style>




@endsection