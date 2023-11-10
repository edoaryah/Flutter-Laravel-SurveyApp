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
            ->orderBy('count', 'desc')
            ->get();
        return $genreCounts;
    }

    public function genderRespondents()
    {
        $genderCounts = DB::table('surveys')
            ->select('Gender', DB::raw('count(*) as count'))
            ->groupBy('Gender')
            ->orderBy('count', 'desc')
            ->get();
        return $genderCounts;
    }

    public function nationalityRespondents()
    {
        $nationalityCounts = DB::table('surveys')
            ->select('Nationality', DB::raw('count(*) as count'))
            ->groupBy('Nationality')
            ->orderBy('count', 'desc')
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

    public function updateRespondent(Request $request, $id)
    {
        $respondent = DB::table('surveys')->where('id', $id)->first();

        if (!$respondent) {
            return response()->json(['message' => 'Respondent not found'], 404);
        }

        DB::table('surveys')->where('id', $id)->update($request->all());

        return response()->json(['message' => 'Respondent updated successfully']);
    }

    public function deleteRespondent($id)
    {
        $respondent = DB::table('surveys')->where('id', $id)->first();

        if (!$respondent) {
            return response()->json(['message' => 'Respondent not found'], 404);
        }

        DB::table('surveys')->where('id', $id)->delete();

        return response()->json(['message' => 'Respondent deleted successfully']);
    }

    public function createRespondent(Request $request)
    {
        $respondent = DB::table('surveys')->insertGetId($request->all());

        if (!$respondent) {
            return response()->json(['message' => 'Failed to create respondent'], 500);
        }

        return response()->json(['message' => 'Respondent created successfully', 'id' => $respondent]);
    }
}
