<!DOCTYPE html>

<html lang="pt-br">

<head>

<meta charset="UTF-8">

<title>
Login
</title>


<style>


*{

    margin:0;

    padding:0;

    box-sizing:border-box;

    font-family:'Segoe UI', Arial, sans-serif;

}



body{


    min-height:100vh;

    display:flex;

    align-items:center;

    justify-content:center;

    background:linear-gradient(
        135deg,
        #2563eb,
        #1e293b
    );


}





.box{


    background:white;

    width:380px;

    padding:35px;

    border-radius:20px;

    box-shadow:

    0 20px 40px rgba(0,0,0,.2);

    animation:aparecer .4s ease;


}



@keyframes aparecer{


    from{

        opacity:0;

        transform:translateY(-20px);

    }


    to{

        opacity:1;

        transform:translateY(0);

    }


}





.logo{


    text-align:center;

    font-size:45px;

    margin-bottom:10px;


}





h2{


    text-align:center;

    margin-bottom:25px;

    color:#1e293b;

    font-size:28px;


}





/* MENSAGENS */


.sucesso{


    background:#dcfce7;

    color:#166534;

    padding:12px;

    border-radius:10px;

    margin-bottom:20px;

    font-size:14px;


}




.erro{


    background:#fee2e2;

    color:#991b1b;

    padding:12px;

    border-radius:10px;

    margin-bottom:20px;

    font-size:14px;


}





/* INPUTS */


input{


    width:100%;

    padding:14px 15px;

    margin-bottom:15px;

    border:1px solid #cbd5e1;

    border-radius:12px;

    font-size:15px;

    outline:none;

    transition:.3s;


}




input:focus{


    border-color:#2563eb;

    box-shadow:

    0 0 0 3px rgba(37,99,235,.15);


}








/* BOTÃO */


button{


    width:100%;

    padding:14px;

    background:#2563eb;

    color:white;

    border:none;

    border-radius:12px;

    font-size:16px;

    font-weight:bold;

    cursor:pointer;

    transition:.3s;


}





button:hover{


    background:#1d4ed8;

    transform:translateY(-2px);


}








a{


    display:block;

    margin-top:20px;

    text-align:center;

    text-decoration:none;

    color:#2563eb;

    font-weight:500;


}



a:hover{


    text-decoration:underline;


}





</style>


</head>



<body>




<div class="box">





<div class="logo">

🔐

</div>





<h2>

Login

</h2>







@if(session('success'))


<div class="sucesso">


{{ session('success') }}


</div>


@endif







@if($errors->any())


<div class="erro">


@foreach($errors->all() as $erro)


<p>

@if($erro == 'These credentials do not match our records.')

Email ou senha incorretos.

@else

{{ $erro }}

@endif

</p>


@endforeach


</div>


@endif







<form method="POST" action="{{ route('login.post') }}">


@csrf





<input

type="email"

name="email"

placeholder="Digite seu email"

value="{{ old('email') }}"

required

>







<input

type="password"

name="password"

placeholder="Digite sua senha"

required

>








<button>

Entrar no sistema

</button>





</form>








<a href="{{ route('register') }}">

Criar novo usuário

</a>





</div>




</body>


</html>