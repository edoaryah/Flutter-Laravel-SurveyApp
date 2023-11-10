<?php

namespace Database\Seeders;

use Illuminate\Support\Facades\DB;
use Illuminate\Database\Seeder;
use League\Csv\Reader;

class SurveySeeder extends Seeder
{
    public function run()
    {
        //arahkan ke path DataUTSMobileFixed.csv
        $csv = Reader::createFromPath('D:\Kuliah\Semester 5\MobileProg\UTS-Mobile-All\Flutter-Laravel-SurveyApp\DataUTSMobileFixed.csv', 'r');
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
