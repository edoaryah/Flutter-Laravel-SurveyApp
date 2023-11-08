<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

class SurveyController extends Controller
{
    public function totalRespondents()
    {
        $totalRespondents = DB::table('surveys')->count();
        return $totalRespondents;
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
        $surveyDetails = DB::table('surveys')->paginate(20);
        return [
            'data' => $surveyDetails->items(),
            'total' => $surveyDetails->total(),
            'per_page' => $surveyDetails->perPage(),
            'current_page' => $surveyDetails->currentPage(),
            'last_page' => $surveyDetails->lastPage(),
        ];
    }

    public function updateSurveyDetails(Request $request, $id)
    {
        $survey = DB::table('surveys')->find($id);
        if ($survey) {
            DB::table('surveys')
                ->where('id', $id)
                ->update([
                    'Genre' => $request->Genre,
                    'Reports' => $request->Reports,
                    'Age' => $request->Age,
                    'Gpa' => $request->Gpa,
                    'Year' => $request->Year,
                    'Gender' => $request->Gender,
                    'Nationality' => $request->Nationality,
                ]);
            return response()->json(['success' => true]);
        } else {
            return response()->json(['success' => false], 404);
        }
    }
}
