<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

class ReportController extends Controller
{
    public function reportDetails()
    {
        $reportDetails = DB::table('reports')->paginate(20);
        return [
            'data' => $reportDetails->items(),
            'total' => $reportDetails->total(),
            'per_page' => $reportDetails->perPage(),
            'current_page' => $reportDetails->currentPage(),
            'last_page' => $reportDetails->lastPage(),
        ];
    }

    public function roleReport()
    {
        $roleCounts = DB::table('reports')
            ->select('Role', DB::raw('count(*) as count'))
            ->groupBy('Role')
            ->orderBy('count', 'desc')
            ->get();
        return $roleCounts;
    }

    public function genderReport()
    {
        $genderCounts = DB::table('reports')
            ->select('Gender', DB::raw('count(*) as count'))
            ->groupBy('Gender')
            ->orderBy('count', 'desc')
            ->get();
        return $genderCounts;
    }

    public function typeReport()
    {
        $typeCounts = DB::table('reports')
            ->select('Type', DB::raw('count(*) as count'))
            ->groupBy('Type')
            ->orderBy('count', 'desc')
            ->get();
        return $typeCounts;
    }

    public function updateReport(Request $request, $id)
    {
        $report = DB::table('reports')->where('id', $id)->first();
        if (!$report) {
            return response()->json(['message' => 'Report not found'], 404);
        }
        DB::table('reports')->where('id', $id)->update($request->all());
        return response()->json(['message' => 'Report updated successfully']);
    }

    public function deleteReport($id)
    {
        $report = DB::table('reports')->where('id', $id)->first();
        if (!$report) {
            return response()->json(['message' => 'Report not found'], 404);
        }
        DB::table('reports')->where('id', $id)->delete();
        return response()->json(['message' => 'Report deleted successfully']);
    }

    public function createReport(Request $request)
    {
        $report = DB::table('reports')->insertGetId($request->all());
        if (!$report) {
            return response()->json(['message' => 'Failed to create report'], 500);
        }
        return response()->json(['message' => 'Report created successfully', 'id' => $report]);
    }
}
