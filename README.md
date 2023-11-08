# UTS PEMROGRAMAN MOBILE - KELOMPOK 3

## Latar Belakang Masalah

Mr. X merupakan Direktur Politeknik terbesar di Indonesia, yang memiliki tanggung jawab untuk menjaga kualitas layanan pendidikan dan aspek pendukung di kampus. Salah satu cara untuk menjaga kualitas tersebut yaitu dengan mengetahui masalah-masalah yang dihadapi oleh para mahasiswa. Untuk mengetahui permasalahan yang dihadapi, Mr. X melakukan survey kepada mahasiswa dari kelas Internasional. Survey ini bertujuan untuk mengumpulkan data mengenai faktor-faktor yang dipermasalahkan oleh mahasiswa, seperti Sumberdaya dan Dukungan Akademik, Layanan Kantin dan Makanan, dan lainnya.

Data hasil survey yang telah dilakukan sangat penting bagi Mr. X untuk mengambil langkah-langkah perbaikan. Dengan mengetahui permasalahan yang dihadapi oleh mahasiswa, Mr. X dapat membuat kebijakan dan program yang tepat untuk meningkatkan kualitas layanan pendidikan dan aspek pendukung di kampus.

Aplikasi mobile survey kualitas pendidikan dan aspek pendukung di kampus dapat menjadi solusi bagi Mr. X untuk mengetahui hasil survey secara cepat dan mudah, dan meningkatkan efisiensi kerja Mr. X. Aplikasi ini dapat menampilkan data hasil survey seperti faktor-faktor yang dipermasalahkan, gender, negara asal, rata-rata umur responden, dan lain sebagainya. Aplikasi ini dapat dikembangkan dengan menggunakan framework Laravel untuk backend dan framework Flutter untuk frontend. Dengan menggunakan framework tersebut, aplikasi dapat dikembangkan dengan cepat dan mudah.

## Flowchart
![Flowchart_Kelompok3](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/114456394/e84b248e-33a9-4e0b-9025-32187b3715db)

Berdasarkan Flowchart Tersebut diketahui pada ketika memulai aplikasi tersebut pada tampilan dashboard terdapat 6 fitur  di dalamnya yang akan ditampilkan yaitu total responden, jumlah faktor yang dipermasalahkan dalam tiap faktornya, jumlah responden berdasarkan gender, rata rata umur responden total, dan rata-rata IPK (GPA) responden total. dimana dalam masing masing fitur tersebut akan ditampilkan dalam dashboard. Data yang ditampilkan tersebut diambil dari database responden. pada dashboard  di dalamnya terdapat button yang terdiri dari button list, home dan form tambahan.  Ketika memilih  menu button Responden nantinya akan diarahkan pada tampilan responden masuk. Pada tiap daftar responden tersebut apabila ditekan nantinya akan tampil detail hasil survei pada tiap respondennya.

## 1 - Tampilan Halaman Home
![Screenshot_3](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/114456394/df3633f7-517c-4560-840b-e4238c27e9b5)
![Screenshot_2](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/114456394/692f1c5a-9d64-4835-93b0-d6b210d3def7)
![Screenshot_1](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/114456394/6b0e61eb-398c-46dd-8e47-f2f175c0f98a)

Pada halaman home terdapat beberapa fitur didalamnya. 
Pertama adalah fitur total responden yang menampilkan jumlah keseluruhan dari hasil survey yang ada dapat dilihat pada gambar total keseluruhan responden sebesar 1005 orang. 
Kedua terdapat fitur gender yang diimplementasikan menggunakan pie chart  yang berisikan jumlah responden berdasarkan jenis kelamin, dapat dilihat pada gambar gender male / laki-laki sebanyak 456 dan untuk female / perempuan sebanyak 549. 
Ketiga adalah fitur Rata-rata responden yang berisikan besaran nilai untuk rata-rata umur dan nilai IPK/GPA, dari seluruh responden yang dari hasil survey mendapatkan nilai rata-rata umur berkisar 21,3 tahun dan rata-rata nilai IPK/GPA sebesar 2,2.
Keempat yaitu fitur jumlah responden untuk tiap negara, pada hasil survey yang telah dilakukan didapatkannya 6 negara, dapat dilihat pada gambar dibawah ini negara yang paling banyak responden berasal dari negara Indonesia. Dibawah fitur ini terdapat bagan chart untuk genre yang berisikan pie chart untuk tiap faktor permasalahan dan bagan chart untuk nationality yang berisikan bar chart untuk responden tiap negaranya.
Fitur kelima adlalah fitur untuk menampilkan jumlah responden dari tiap faktor permasalahan yang diimplementasikan menggunakan bar chart. Dari data survey yang telah dilakukan, mendapatkan 11 faktor permasalahan yang ada. Pada halaman home tersebut telah menampilkan 11 faktor yang ada beserta dengan jumlah respondennya. 

## 2 - Tampilan Halaman List
![Screenshot_6](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/114456394/587f5ab5-6189-46f4-8a54-b65366b1cd3b)
![Screenshot_5](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/114456394/c9b3651b-9155-4ace-8208-4ccbf1841a7b)
![Screenshot_4](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/114456394/a0ee3375-d583-483e-9022-6d67f6b829eb)

Pada halaman list tertera daftar responden yang ada dan pada halaman ini untuk mengetahui detail dari respondent tersebut dapat menekan list responden yang ada yang nantinya akan muncul pop up yang berisikan detail dari respondent.

## Daftar Kontributor
| Anggota | Akun Github | Tugas |
| ------ | ------ | ------ |
| Ahmad Shodikin / 03 / 2141762132 | github.com/AhmadShodikinn | Front End |
| Clauria Dwi Putri Nabillah 06 / 2141762029 | github.com/ClauriaDwiPN | Pengolahan Data & Pelaporan |
| Edo Arya Hermawan / 07 / 2141762068 | github.com/edoaryah | Back End |
| Rendy Septian Pradana / 20 / 2141762018 | github.com/Rendyseptch | Dokumentasi & Pelaporan |

## Dokumentasi Kegiatan
![Dokumentasi_Kelompok3](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/114456394/a5c8eb7f-60c7-4102-a43e-1a01e7646108)
