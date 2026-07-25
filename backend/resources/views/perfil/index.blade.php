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



<div class="profile-photo">



@if(auth()->user()->foto)


<img 
src="{{ asset('storage/'.auth()->user()->foto) }}"
alt="Foto de perfil">



@else


<span>

{{ strtoupper(substr(auth()->user()->name,0,1)) }}

</span>


@endif



</div>






<form method="POST" 
action="{{ route('perfil.update') }}"
enctype="multipart/form-data">


@csrf




<label>
Alterar foto de perfil
</label>


<input 
type="file"
name="foto"
accept="image/*">





<label>
Nome
</label>


<input 
type="text"
name="name"
value="{{ auth()->user()->name }}"
required>





<label>
Email
</label>


<input 
type="email"
name="email"
value="{{ auth()->user()->email }}"
required>






<label>
Nova senha
</label>


<input 
type="password"
name="password"
placeholder="Deixe vazio para manter a senha atual">






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

box-shadow:0 5px 15px #0001;

}



.profile-photo{

width:150px;

height:150px;

border-radius:50%;

overflow:hidden;

background:#2563eb;

display:flex;

align-items:center;

justify-content:center;

margin:0 auto 30px;

}



.profile-photo img{

width:100%;

height:100%;

object-fit:cover;

}



.profile-photo span{

color:white;

font-size:60px;

font-weight:bold;

}



form{

display:flex;

flex-direction:column;

gap:15px;

}



label{

font-weight:bold;

}



input{

padding:12px;

border-radius:10px;

border:1px solid #ccc;

font-size:16px;

}



input[type="file"]{

background:#f8fafc;

}



.btn{

background:#2563eb;

color:white;

padding:12px;

border:none;

border-radius:10px;

cursor:pointer;

font-size:16px;

}



.btn:hover{

background:#1d4ed8;

}



</style>



@endsection