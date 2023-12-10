<?php

namespace Database\Seeders;

use Illuminate\Support\Facades\DB;
use Illuminate\Database\Seeder;
use League\Csv\Reader;

class KelulusanSeeder extends Seeder
{
    public function run(): void
    {
        $csv = Reader::createFromPath('C:\Users\edoar\Documents\College\SurveyApp\data_kelulusan.csv', 'r');
        $csv->setHeaderOffset(0);

        foreach ($csv as $record) {
            DB::table('kelulusans')->insert([
                'Nama' => $record['Nama'],
                'Nim' => $record['Nim'],
                'Tahun_Lulus' => $record['Tahun_Lulus'],
            ]);
        }
    }
}
