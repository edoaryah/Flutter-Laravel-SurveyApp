# SIREMA - KELOMPOK 3
![sirema](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/114456394/21e40a8f-f66c-4f4a-b1c8-6de93a72920d)

## Brief Description

Selamat datang di aplikasi mobile survei kualitas pendidikan dan aspek pendukung di kampus yang dikembangkan atas inisiatif Mr. X, seorang Direktur dari Politeknik terbesar di Indonesia. Dalam peranannya sebagai pemimpin, Mr. X bertanggung jawab menjaga dan meningkatkan kualitas layanan pendidikan serta aspek pendukung di lingkungan kampus. 

## Survey Objectives

Salah satu upaya signifikan yang diambil oleh Mr. X adalah melakukan survei khusus kepada mahasiswa kelas Internasional. Tujuan survei ini adalah untuk mengidentifikasi masalah-masalah yang dihadapi oleh mahasiswa, dengan fokus pada faktor-faktor krusial seperti Sumberdaya dan Dukungan Akademik, Layanan Kantin dan Makanan, serta aspek lain yang berpengaruh.

## Importance of Survey Data

Hasil dari survei ini membekali Mr. X dengan informasi yang sangat berharga. Dengan pemahaman mendalam terhadap permasalahan yang dihadapi mahasiswa, Mr. X dapat merancang kebijakan dan program spesifik untuk meningkatkan kualitas layanan pendidikan dan aspek pendukung di lingkungan kampus.

## Mobile Application Solution

Aplikasi mobile survei ini muncul sebagai solusi inovatif bagi Mr. X. Dengan kecepatan dan kemudahan akses, aplikasi ini memungkinkan Mr. X untuk mendapatkan hasil survei secara instan, meminimalkan waktu kerja yang dibutuhkan. Aplikasi ini menyajikan data survei dengan detail, termasuk faktor-faktor yang dipermasalahkan, informasi gender, asal negara responden, rata-rata usia, dan variabel lain yang relevan.

## Technology Used

Aplikasi ini dikembangkan menggunakan teknologi terkini, dengan backend menggunakan framework Laravel dan frontend menggunakan framework Flutter. Pilihan ini diambil untuk memastikan pengembangan aplikasi berlangsung dengan cepat, mudah, dan efisien.

## Daftar Kontributor
| Anggota | Akun Github | Tugas |
| ------ | ------ | ------ |
| Ahmad Shodikin / 03 / 2141762132 | github.com/AhmadShodikinn | Front End |
| Clauria Dwi Putri Nabillah 06 / 2141762029 | github.com/ClauriaDwiPN | Pengolahan Data & Pelaporan |
| Edo Arya Hermawan / 07 / 2141762068 | github.com/edoaryah | Back End |
| Rendy Septian Pradana / 20 / 2141762018 | github.com/Rendyseptch | Dokumentasi & Pelaporan |

## Video Presentasi dan Demonstrasi

https://youtu.be/pJ5E9GFdFiE?si=SaLXTOmjYqMXEegA

## Alur Program
Ketika membuka aplikasi ini pertama kali pengguna akan diminta untuk melakukan autentikasi menggunakan email dan password yang telah terdaftar. Setelah berhasil login menggunakan email kampus dan menekan tombol Sign In, pengguna menunggu beberapa detik hingga data muncul. Pada appbar, terdapat ikon user yang ketika diklik akan menampilkan informasi email yang digunakan untuk login. 

![login](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/92168645/cd3871fb-01a6-4765-a49b-78c4eb13ad00)![informasi login](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/92168645/046ba6fd-0853-4962-bdbb-b2ce77f6b2f3)


Halaman home menampilkan informasi total responden, visualisasi pie chart untuk jumlah responden berdasarkan gender, rata-rata umur, dan GPA atau IPK dari keseluruhan responden. Selanjutnya, terdapat bagian untuk visualisasi asal negara atau kewarganegaraan responden dalam bentuk bar chart. Bagian berikutnya terdapat probloem genre, dengan visualisasi bar chart untuk jumlah responden berdasarkan bidang masalah. Bagian terakhir pada halaman home adalah Graduation of Students, menampilkan presentase kelulusan mahasiswa pada setiap tahunnya dalam bentuk bar chart.

![dashboard](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/92168645/5b8b2a07-0dc0-45ba-a30f-a013895b21dc)
![bart chart negara](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/92168645/48fa1ead-1117-45c1-9622-7f0828bd6f4a)
![bart chart genre permasalahan](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/92168645/84caf474-b7e0-4ff0-9fa8-29f273143d8e)
![persentase kelulusan](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/92168645/36610e5a-0655-4c1d-afdf-7f698aa0b7cb)


Pada halaman yang lain, terdapat halaman survey. Disini terdapat detail respondent setiap ID, mencakup informasi seperti gender, umur GPA, tahun, bidang permasalahan, dan keluhan. Dengan pagination, setiap halaman menampilkan 20 ID, dan tombol panah kanan membawa pengguna ke halaman terakhir. Setiap card respondent ID dapat diedit, dengan kemampuan mengganti genre, kewarganegaraan, dan menghapus data. 

![tampilan seluruh survey](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/92168645/24f77797-afa8-4240-85f9-087931156130)
![informasi detail survey](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/92168645/d86df1fb-e010-4756-b793-b89115dd74cd)
![edit survey](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/92168645/cbfb3ee1-5eec-40c9-8510-8e3808afec44)
![manghapus laporn survey](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/92168645/9c902ee6-bdee-432e-b2e8-22a04b959e93)


Halaman report, menampilkan laporan yang berkaitan dengan kekerasan di lingkungan kampus. Pengguna dapat memilih dan melihat detail laporan mahasiswa tertentu, mengedit data, dan menghapus laporan melalui fungsi serupa seperti pada halaman survey. 

Survey Form merupakan halaman dimana mahasiswa dapat mengisi form untuk menyampaikan keluhan atau memberikan masukan kepada pihak kampus. Setelah mengisi kolom umur, gender, GPA, year, genre, dan isi report, data dapat dilihat pada halaman Survey sebagai respondent ID baru. 

Report Form memungkinkan mahasiswa melaporkan tindakan kekerasan di kampus. Melalui form ini, mahasiswa mengisi nama, umur, gender, status korban atau saksi mata, jenis tindakan kekerasan, dan kronologi kejadian. Data yang di submit dapat dilihat pada halaman report. 

Terakhir, pengguna dapat logout dengan menekan ikon logout pada appbar, kembali ke halaman login atau auth. Sistem ini menyajikan suatu platform yang komprehensif untuk manajemen data dan pelaporan terkait kekerasan di lingkungan kampus.

## Dokumentasi Kegiatan
![Dokumentasi_Kelompok3](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/114456394/a5c8eb7f-60c7-4102-a43e-1a01e7646108)
