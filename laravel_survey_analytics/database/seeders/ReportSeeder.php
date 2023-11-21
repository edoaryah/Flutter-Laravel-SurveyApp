<?php

namespace Database\Seeders;

use Illuminate\Support\Facades\DB;
use Illuminate\Database\Seeder;
use League\Csv\Reader;

class ReportSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        //arahkan ke path DataUTSMobileFixed.csv
        $csv = Reader::createFromPath('C:\Users\edoar\Documents\College\SurveyApp\reports.csv', 'r');
        $csv->setHeaderOffset(0);

        foreach ($csv as $record) {
            DB::table('reports')->insert([
                'Name' => $record['Name'],
                'Age' => $record['Age'],
                'Gender' => $record['Gender'],
                'Role' => $record['Role'],
                'Type' => $record['Type'],
                'Reports' => $record['Reports'],
            ]);
        }
    }
}
