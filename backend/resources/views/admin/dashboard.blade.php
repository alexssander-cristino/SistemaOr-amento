@extends('admin.layout')


@section('title','Dashboard')


@section('content')



<div class="header">

<h1>
📊 Dashboard
</h1>

<p>
Visão geral do sistema de eventos
</p>

</div>





<div class="cards">



<div class="card">

<h2>
{{ $clientes }}
</h2>

<p>
👥 Clientes cadastrados
</p>

</div>




<div class="card">

<h2>
{{ $eventos }}
</h2>

<p>
📅 Eventos
</p>

</div>





<div class="card">

<h2>
{{ $servicos }}
</h2>

<p>
📦 Serviços
</p>

</div>





<div class="card">

<h2>
{{ $orcamentos }}
</h2>

<p>
💰 Orçamentos
</p>

</div>



</div>







<br>







<div class="table-box">


<h2>
📈 Estatísticas do Sistema
</h2>



<canvas id="grafico"></canvas>


</div>








<br>







<div class="table-box">


<h2>
🍩 Distribuição dos Dados
</h2>



<canvas id="graficoPizza"></canvas>


</div>







<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>




<script>


const ctx = document
.getElementById('grafico');



new Chart(ctx, {


type:'bar',


data:{


labels:[

'Clientes',

'Eventos',

'Serviços',

'Orçamentos'

],



datasets:[{

label:'Quantidade',


data:[

{{ $clientes }},

{{ $eventos }},

{{ $servicos }},

{{ $orcamentos }}

],



borderWidth:1


}]


},



options:{


responsive:true,


scales:{


y:{


beginAtZero:true


}


}



}



});









const pizza = document
.getElementById('graficoPizza');



new Chart(pizza,{


type:'doughnut',



data:{


labels:[

'Clientes',

'Eventos',

'Serviços',

'Orçamentos'

],



datasets:[{


data:[


{{ $clientes }},

{{ $eventos }},

{{ $servicos }},

{{ $orcamentos }}


],



borderWidth:1


}]



},



options:{


responsive:true


}



});



</script>






<style>


canvas{


max-height:350px;


}



.table-box{


background:white;

padding:25px;

border-radius:15px;

box-shadow:0 5px 15px #0001;


}



</style>





@endsection