<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\SurveyController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('/total-respondents', [SurveyController::class, 'totalRespondents']);
Route::get('/respondents-by-genre', [SurveyController::class, 'genreRespondents']);
Route::get('/respondents-by-gender', [SurveyController::class, 'genderRespondents']);
Route::get('/respondents-by-nationality', [SurveyController::class, 'nationalityRespondents']);
Route::get('/average-age', [SurveyController::class, 'averageAge']);
Route::get('/average-gpa', [SurveyController::class, 'averageGpa']);
Route::get('/survey-details', [SurveyController::class, 'surveyDetails']);
Route::put('/respondent/{id}', [SurveyController::class, 'updateRespondent']);
Route::delete('/respondent/{id}', [SurveyController::class, 'deleteRespondent']);
Route::post('/respondent', [SurveyController::class, 'createRespondent']);
