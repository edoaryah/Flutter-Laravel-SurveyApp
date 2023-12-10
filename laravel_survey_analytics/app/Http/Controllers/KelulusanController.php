<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;

class KelulusanController extends Controller
{
    public function jumlahKelulusan()
    {
        $countKelulusans = DB::table('kelulusans')
            ->select('Tahun_Lulus', DB::raw('count(*) as count'))
            ->groupBy('Tahun_Lulus')
            ->orderBy('Tahun_Lulus', 'asc')
            ->get();
        return $countKelulusans;
    }
}
