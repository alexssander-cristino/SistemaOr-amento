@extends('admin.layout')


@section('title','Minha Conta')



@section('content')



<div class="header">

<h1>

👤 Minha Conta

</h1>


<p>

Gerencie seus dados de usuário

</p>


</div>






<div class="table-box">



@if(session('success'))

<div class="success">

{{ session('success') }}

</div>

@endif






<form method="POST"

action="{{ route('admin.perfil.update') }}"

enctype="multipart/form-data">


@csrf





<div class="foto-area">


@if($usuario->foto)


<img 

src="{{ asset('storage/'.$usuario->foto) }}"

class="foto"

>



@else


<div class="avatar">

{{ strtoupper(substr($usuario->name,0,1)) }}

</div>


@endif



</div>





<label>

Foto de perfil

</label>


<input 

type="file"

name="foto"

accept="image/*"

>






<label>

Nome

</label>


<input

type="text"

name="name"

value="{{ $usuario->name }}"

required

>






<label>

Email

</label>


<input

type="email"

name="email"

value="{{ $usuario->email }}"

required

>






<hr>




<h3>

Alterar senha

</h3>



<input

type="password"

name="password"

placeholder="Nova senha"



>




<input

type="password"

name="password_confirmation"

placeholder="Confirmar nova senha"



>






<button class="btn">

💾 Salvar alterações

</button>




</form>



</div>






<style>


.table-box{

background:white;

padding:30px;

border-radius:15px;

max-width:600px;

}



form{

display:flex;

flex-direction:column;

gap:15px;

}




input{


padding:12px;

border:1px solid #ccc;

border-radius:8px;


}



.foto-area{


display:flex;

justify-content:center;

margin-bottom:20px;


}




.foto,
.avatar{


width:120px;

height:120px;

border-radius:50%;

object-fit:cover;

}





.avatar{


background:#2563eb;

color:white;

display:flex;

align-items:center;

justify-content:center;

font-size:50px;

font-weight:bold;


}




.btn{


background:#2563eb;

color:white;

border:none;

padding:12px;

border-radius:10px;

cursor:pointer;


}



.success{


background:#d1fae5;

color:#065f46;

padding:15px;

border-radius:10px;

margin-bottom:20px;


}



</style>




@endsection