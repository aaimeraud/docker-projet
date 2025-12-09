<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
     $serverId = env('SERVER_ID', 0);
    $message = [

        1 => 'Server 1',
        2 => 'Server 2 clique ici'
    ];
    $message = $message[$serverId] ?? 'Server Inconnu';
    return view('welcome', compact('message'));
});

Route::get('/dashboard', function () {
    return view('dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

require __DIR__.'/auth.php';
