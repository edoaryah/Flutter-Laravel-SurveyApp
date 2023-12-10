<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Kelulusan extends Model
{
    use HasFactory;

    protected $table = 'kelulusans';

    protected $fillable = [
        'Nama',
        'Nim',
        'Tahun_Lulus',
    ];
}
