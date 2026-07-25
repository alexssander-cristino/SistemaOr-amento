<!DOCTYPE html>
<html lang="pt-br">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>
@yield('title') - EventManager
</title>


<style>


*{

margin:0;

padding:0;

box-sizing:border-box;

font-family:Arial, Helvetica, sans-serif;

}



body{

background:#f5f6fa;

}



/* =====================
BOTÃO MOBILE
===================== */


.mobile-btn{

display:none;

position:fixed;

top:15px;

left:15px;

z-index:1000;

background:#2563eb;

color:white;

border:none;

padding:12px 15px;

font-size:22px;

border-radius:10px;

cursor:pointer;

}





/* =====================
SIDEBAR
===================== */


.sidebar{

width:270px;

height:100vh;

background:#1e293b;

color:white;

padding:25px;

position:fixed;

left:0;

top:0;

overflow-y:auto;

transition:.3s;

z-index:999;

}





.logo{

font-size:22px;

font-weight:bold;

text-align:center;

margin-bottom:25px;

}





/* USUARIO */


.user-panel{


background:#334155;

padding:15px;

border-radius:15px;

margin-bottom:25px;


}



.user-header{

display:flex;

align-items:center;

gap:12px;

}



.avatar{

width:55px;

height:55px;

border-radius:50%;

overflow:hidden;

background:#2563eb;

display:flex;

align-items:center;

justify-content:center;

flex-shrink:0;

}



.avatar img{

width:100%;

height:100%;

object-fit:cover;

}



.avatar span{

font-size:24px;

font-weight:bold;

}





.user-data{

overflow:hidden;

}



.user-data h3{

font-size:16px;

}



.user-data p{

font-size:12px;

color:#cbd5e1;

overflow:hidden;

text-overflow:ellipsis;

white-space:nowrap;

}





/* BOTÕES */


.account-buttons{

margin-top:15px;

}



.account-buttons a,
.account-buttons button{


display:flex;

justify-content:center;

align-items:center;

width:100%;

padding:10px;

border-radius:8px;

border:none;

margin-top:8px;

cursor:pointer;

text-decoration:none;

font-size:14px;

}



.profile-btn{

background:#475569;

color:white;

}



.change-btn{

background:#2563eb;

color:white;

}



.logout-btn{

background:#dc2626;

color:white;

}






/* MENU */


.sidebar a.menu{


display:block;

color:#cbd5e1;

text-decoration:none;

padding:13px;

margin-bottom:8px;

border-radius:8px;

transition:.3s;

}



.sidebar a.menu:hover{


background:#334155;

color:white;

transform:translateX(5px);


}







/* =====================
CONTEÚDO
===================== */


.content{


margin-left:270px;

padding:30px;

width:calc(100% - 270px);


}





.header{


background:white;

padding:20px;

border-radius:12px;

margin-bottom:25px;

box-shadow:0 5px 15px #0001;


}







/* CARDS */


.cards{


display:grid;

grid-template-columns:repeat(auto-fit,minmax(200px,1fr));

gap:20px;


}



.card{


background:white;

padding:25px;

border-radius:15px;

box-shadow:0 5px 15px #0001;


}



.card h2{

font-size:35px;

}







/* TABELAS */


.table-box{


background:white;

padding:25px;

border-radius:15px;

box-shadow:0 5px 15px #0001;

overflow-x:auto;

}



table{


width:100%;

border-collapse:collapse;

}



th{


background:#1e293b;

color:white;


}



td,th{


padding:12px;

text-align:left;

}







/* BOTÕES */


.btn{


display:inline-block;

padding:10px 18px;

background:#2563eb;

color:white;

border-radius:8px;

border:none;

cursor:pointer;

}





/* =====================
TABLET
===================== */


@media(max-width:900px){



.sidebar{


left:-270px;


}



.sidebar.active{


left:0;


}



.mobile-btn{


display:block;


}



.content{


margin-left:0;

width:100%;

padding:20px;

padding-top:80px;


}



.cards{


grid-template-columns:1fr;


}



.header h1{


font-size:22px;

}



.table-box{


overflow-x:auto;

}



table{


min-width:700px;

}



}






/* =====================
CELULAR PEQUENO
===================== */


@media(max-width:480px){



.content{


padding:15px;

padding-top:75px;

}



.card{


padding:18px;

}



.card h2{


font-size:28px;


}



.user-header{


gap:8px;


}



.avatar{


width:45px;

height:45px;


}



.logo{


font-size:18px;


}



}






</style>


</head>



<body>




<button class="mobile-btn" onclick="abrirMenu()">

☰

</button>





<div class="sidebar" id="sidebar">



<div class="logo">

🎉 EventManager

</div>






<div class="user-panel">


<div class="user-header">


<div class="avatar">


@if(auth()->user()->foto)

<img 
src="{{ asset('storage/'.auth()->user()->foto) }}">


@else


<span>

{{ strtoupper(substr(auth()->user()->name,0,1)) }}

</span>


@endif


</div>




<div class="user-data">


<h3>

{{ auth()->user()->name }}

</h3>


<p>

{{ auth()->user()->email }}

</p>


</div>


</div>






<div class="account-buttons">


<a href="{{ route('perfil') }}"
class="profile-btn">

👤 Minha Conta

</a>



<form method="POST"
action="{{ route('logout') }}">


@csrf


<button class="logout-btn">

🚪 Sair

</button>


</form>


</div>



</div>







<a class="menu" href="/admin">

📊 Dashboard

</a>



<a class="menu" href="/admin/categorias">

📂 Categorias

</a>



<a class="menu" href="/admin/clientes">

👥 Clientes

</a>



<a class="menu" href="/admin/eventos">

📅 Eventos

</a>



<a class="menu" href="/admin/eventos/lista">

📋 Lista de Eventos

</a>



<a class="menu" href="/admin/servicos">

📦 Serviços

</a>



<a class="menu" href="/admin/categorias-eventos">

🎉 Tipos de Evento

</a>



<a class="menu" href="/admin/orcamentos">

💰 Orçamentos

</a>



</div>







<div class="content">


@yield('content')


</div>








<script>


function abrirMenu(){


document
.getElementById('sidebar')
.classList
.toggle('active');


}



</script>



</body>


</html>