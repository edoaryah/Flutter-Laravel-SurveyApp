<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;

class SurveyController extends Controller
{
    public function totalRespondents()
    {
        $totalRespondents = DB::table('surveys')->count();
        return "Total Responden : $totalRespondents";
    }

    public function genreRespondents()
    {
        $genreCounts = DB::table('surveys')
            ->select('Genre', DB::raw('count(*) as count'))
            ->groupBy('Genre')
            ->get();
        return $genreCounts;
    }

    public function genderRespondents()
    {
        $genderCounts = DB::table('surveys')
            ->select('Gender', DB::raw('count(*) as count'))
            ->groupBy('Gender')
            ->get();
        return $genderCounts;
    }

    public function nationalityRespondents()
    {
        $nationalityCounts = DB::table('surveys')
            ->select('Nationality', DB::raw('count(*) as count'))
            ->groupBy('Nationality')
            ->get();
        return $nationalityCounts;
    }

    public function averageAge()
    {
        $averageAge = DB::table('surveys')->avg('Age');
        $formattedAverageAge = number_format($averageAge, 1);
        return $formattedAverageAge;
    }

    public function averageGPA()
    {
        $averageGPA = DB::table('surveys')->avg('Gpa');
        $formattedAverageGPA = number_format($averageGPA, 1);
        return $formattedAverageGPA;
    }

    public function surveyDetails()
    {
        $surveyDetails = DB::table('surveys')->get();
        return $surveyDetails;
    }
    
}
