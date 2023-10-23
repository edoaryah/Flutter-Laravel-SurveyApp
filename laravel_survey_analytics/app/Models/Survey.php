<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Survey extends Model
{
    use HasFactory;

    protected $table = 'surveys';

    protected $fillable = [
        'Genre',
        'Reports',
        'Age',
        'Gpa',
        'Year',
        'Count',
        'Gender',
        'Nationality'
    ];
}
