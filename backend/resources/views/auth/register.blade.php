<!DOCTYPE html>

<html lang="pt-br">

<head>

<meta charset="UTF-8">

<title>
Cadastro
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



/* CARD */


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





h2{


    text-align:center;

    margin-bottom:25px;

    color:#1e293b;

    font-size:28px;


}





/* ERROS */


.erro{


    background:#fee2e2;

    color:#991b1b;

    padding:15px;

    border-radius:12px;

    margin-bottom:20px;

    font-size:14px;


}



.erro ul{


    padding-left:20px;


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




.logo{


    text-align:center;

    font-size:45px;

    margin-bottom:10px;


}




</style>


</head>



<body>



<div class="box">



<div class="logo">

🎉

</div>



<h2>

Criar Usuário

</h2>





@if($errors->any())


<div class="erro">


<strong>

Corrija os seguintes erros:

</strong>


<ul>


@foreach($errors->all() as $erro)


<li>


@php


$mensagem = match($erro) {


    'The name field is required.'
        => 'O campo nome é obrigatório.',


    'The email field is required.'
        => 'O campo email é obrigatório.',


    'The email must be a valid email address.'
        => 'Informe um email válido.',


    'The email has already been taken.'
        => 'Este email já está cadastrado.',


    'The password field is required.'
        => 'O campo senha é obrigatório.',


    'The password field must be at least 6 characters.'
        => 'A senha deve ter no mínimo 6 caracteres.',


    'The password field confirmation does not match.'
        => 'A confirmação da senha não confere.',


    default
        => $erro


};


@endphp



{{ $mensagem }}



</li>


@endforeach


</ul>


</div>


@endif







<form method="POST" action="{{ route('register.store') }}">


@csrf





<input 

type="text"

name="name"

placeholder="Nome completo"

value="{{ old('name') }}"

required

>






<input 

type="email"

name="email"

placeholder="Email"

value="{{ old('email') }}"

required

>







<input 

type="password"

name="password"

placeholder="Senha"

required

>







<input 

type="password"

name="password_confirmation"

placeholder="Confirmar senha"

required

>







<button>

Cadastrar usuário

</button>



</form>







<a href="{{ route('login') }}">

Já tenho uma conta

</a>





</div>



</body>


</html>