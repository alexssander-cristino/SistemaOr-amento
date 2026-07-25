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

display:flex;

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

overflow-y:auto;


}




.logo{


font-size:22px;

font-weight:bold;

text-align:center;

margin-bottom:25px;


}





/* =====================
USUARIO
===================== */



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

background:#2563eb;

overflow:hidden;

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

color:white;


}





.user-data{


overflow:hidden;


}



.user-data h3{


font-size:16px;

margin-bottom:5px;


}



.user-data p{


font-size:12px;

color:#cbd5e1;

overflow:hidden;

text-overflow:ellipsis;

white-space:nowrap;

max-width:150px;


}





/* BOTÕES DA CONTA */


.account-buttons{


margin-top:15px;


}




.account-buttons a,
.account-buttons button{


display:block;

width:100%;

padding:10px;

border-radius:8px;

border:none;

margin-top:8px;

text-align:center;

text-decoration:none;

cursor:pointer;

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





.profile-btn:hover,
.change-btn:hover,
.logout-btn:hover{


opacity:.85;


}







/* =====================
MENU
===================== */



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
CONTEUDO
===================== */


.content{


margin-left:270px;

padding:30px;

width:100%;


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

text-decoration:none;

border:none;

cursor:pointer;


}





/* =====================
MOBILE
===================== */


@media(max-width:768px){


.sidebar{


width:80px;

padding:15px;


}



.logo{


font-size:14px;


}




.user-data,
.account-buttons a,
.account-buttons button{


font-size:0;


}




.content{


margin-left:80px;

padding:15px;


}



}





</style>


</head>




<body>





<div class="sidebar">



<div class="logo">

🎉 EventManager

</div>







<div class="user-panel">



<div class="user-header">



<div class="avatar">



@if(auth()->user()->foto)


<img 
src="{{ asset('storage/'.auth()->user()->foto) }}"
alt="Foto">


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




<a href="{{ route('login') }}"
class="change-btn">

🔄 Trocar Conta

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






</body>


</html>