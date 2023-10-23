<?php

namespace Database\Seeders;

use Illuminate\Support\Facades\DB;
use Illuminate\Database\Seeder;
use League\Csv\Reader;

class SurveySeeder extends Seeder
{
    public function run()
    {
        $csv = Reader::createFromPath('C:\Users\edoar\Documents\College\All Files\DataUTSMobileFixed.csv', 'r');
        $csv->setHeaderOffset(0);

        foreach ($csv as $record) {
            DB::table('surveys')->insert([
                'Genre' => $record['Genre'],
                'Reports' => $record['Reports'],
                'Age' => $record['Age'],
                'Gpa' => $record['Gpa'],
                'Year' => $record['Year'],
                'Count' => $record['Count'],
                'Gender' => $record['Gender'],
                'Nationality' => $record['Nationality'],
            ]);
        }
    }
}
