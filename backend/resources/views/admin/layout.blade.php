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
   MENU LATERAL
===================== */


.sidebar{

    width:250px;

    height:100vh;

    background:#1e293b;

    color:white;

    padding:25px;

    position:fixed;

    overflow-y:auto;

}



.logo{

    font-size:24px;

    font-weight:bold;

    margin-bottom:40px;

    text-align:center;

}



.sidebar a{

    display:block;

    color:#cbd5e1;

    text-decoration:none;

    padding:14px;

    margin-bottom:10px;

    border-radius:8px;

    transition:0.3s;

}



.sidebar a:hover{

    background:#334155;

    color:white;

    transform:translateX(5px);

}





/* =====================
   CONTEÚDO
===================== */


.content{

    margin-left:250px;

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





/* =====================
   CARDS
===================== */


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

    margin-bottom:10px;

}





/* =====================
   TABELAS
===================== */


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



tr:nth-child(even){

    background:#f1f5f9;

}





/* =====================
   BOTÕES
===================== */


.btn{

    display:inline-block;

    padding:10px 18px;

    background:#2563eb;

    color:white;

    border-radius:8px;

    text-decoration:none;

    margin-bottom:15px;

    border:none;

    cursor:pointer;

}



.btn:hover{

    background:#1d4ed8;

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

    font-size:18px;

}



.sidebar a{

    font-size:0;

    text-align:center;

}



.sidebar a::first-letter{

    font-size:25px;

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

🎉 Sistema De Eventos

</div>




<a href="/admin">
📊 Dashboard
</a>




<a href="/admin/categorias">
📂 Categorias
</a>



<a href="/admin/clientes">
👥 Clientes
</a>




<a href="/admin/eventos">
📅 Eventos
</a>




<a href="/admin/eventos/lista">
📋 Lista de Eventos
</a>




<a href="/admin/servicos">
📦 Serviços
</a>






<a href="/admin/categorias-eventos">
🎉 Tipos de Evento
</a>




<a href="/admin/orcamentos">
💰 Orçamentos
</a>




</div>






<div class="content">


@yield('content')


</div>





</body>


</html>