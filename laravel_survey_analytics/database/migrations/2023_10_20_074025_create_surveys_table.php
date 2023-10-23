<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('surveys', function (Blueprint $table) {
            $table->increments('id');
            $table->string('Genre');
            $table->text('Reports');
            $table->integer('Age');
            $table->decimal('Gpa', 8, 2);
            $table->integer('Year');
            $table->integer('Count');
            $table->char('Gender', 1);
            $table->string('Nationality');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('surveys');
    }
};
