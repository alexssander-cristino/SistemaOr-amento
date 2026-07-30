<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class UsuarioController extends Controller
{
    /**
     * Retorna o usuário autenticado
     */
    public function usuario()
    {
        $usuario = auth()->user();

        if (!$usuario) {
            return response()->json([
                "message" => "Usuário não autenticado"
            ], 401);
        }

        if (!empty($usuario->foto)) {
            $usuario->foto = asset('storage/' . ltrim($usuario->foto, '/'));
        }

        return response()->json($usuario);
    }

    /**
     * Atualiza nome e email
     */
    public function update(Request $request)
    {
        $usuario = auth()->user();

        if (!$usuario) {
            return response()->json([
                "message" => "Usuário não autenticado"
            ], 401);
        }

        $dados = $request->validate([
            'name'  => 'required|string|max:255',
            'email' => 'required|email|max:255',
        ]);

        $usuario->update($dados);

        $usuario->refresh();

        if (!empty($usuario->foto)) {
            $usuario->foto = asset('storage/' . ltrim($usuario->foto, '/'));
        }

        return response()->json([
            "success" => true,
            "message" => "Perfil atualizado",
            "usuario" => $usuario
        ]);
    }

    /**
     * Upload da foto
     */
    public function foto(Request $request)
    {
        $request->validate([
            'foto' => 'required|image|mimes:jpg,jpeg,png|max:2048'
        ]);

        $usuario = auth()->user();

        if (!$usuario) {
            return response()->json([
                "message" => "Usuário não autenticado"
            ], 401);
        }

        /*
        |------------------------------------------------------------
        | Remove foto antiga
        |------------------------------------------------------------
        */

        if (!empty($usuario->foto)) {

            $arquivo = $usuario->foto;

            $arquivo = str_replace(asset('storage/') . '/', '', $arquivo);
            $arquivo = str_replace(asset('storage/'), '', $arquivo);
            $arquivo = ltrim($arquivo, '/');

            if (Storage::disk('public')->exists($arquivo)) {
                Storage::disk('public')->delete($arquivo);
            }
        }

        /*
        |------------------------------------------------------------
        | Salva nova foto
        |------------------------------------------------------------
        */

        $path = $request
            ->file('foto')
            ->store('usuarios', 'public');

        $usuario->foto = $path;
        $usuario->save();

        $usuario->refresh();

        $usuario->foto = asset('storage/' . $path);

        return response()->json([
            "success" => true,
            "message" => "Foto atualizada com sucesso.",
            "foto" => $usuario->foto,
            "usuario" => $usuario
        ]);
    }
}