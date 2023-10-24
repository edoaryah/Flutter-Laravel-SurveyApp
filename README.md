# UTS PEMROGRAMAN MOBILE - KELOMPOK 3

## Latar Belakang Masalah

Mr. X merupakan Direktur Politeknik terbesar di Indonesia, yang memiliki tanggung jawab untuk menjaga kualitas layanan pendidikan dan aspek pendukung di kampus. Salah satu cara untuk menjaga kualitas tersebut yaitu dengan mengetahui masalah-masalah yang dihadapi oleh para mahasiswa. Untuk mengetahui permasalahan yang dihadapi, Mr. X melakukan survey kepada mahasiswa dari kelas Internasional. Survey ini bertujuan untuk mengumpulkan data mengenai faktor-faktor yang dipermasalahkan oleh mahasiswa, seperti Sumberdaya dan Dukungan Akademik, Layanan Kantin dan Makanan, dan lainnya.

Data hasil survey yang telah dilakukan sangat penting bagi Mr. X untuk mengambil langkah-langkah perbaikan. Dengan mengetahui permasalahan yang dihadapi oleh mahasiswa, Mr. X dapat membuat kebijakan dan program yang tepat untuk meningkatkan kualitas layanan pendidikan dan aspek pendukung di kampus.

Aplikasi mobile survey kualitas pendidikan dan aspek pendukung di kampus dapat menjadi solusi bagi Mr. X untuk mengetahui hasil survey secara cepat dan mudah, dan meningkatkan efisiensi kerja Mr. X. Aplikasi ini dapat menampilkan data hasil survey seperti faktor-faktor yang dipermasalahkan, gender, negara asal, rata-rata umur responden, dan lain sebagainya. Aplikasi ini dapat dikembangkan dengan menggunakan framework Laravel untuk backend dan framework Flutter untuk frontend. Dengan menggunakan framework tersebut, aplikasi dapat dikembangkan dengan cepat dan mudah.

## Flowchart
![Flowchart_Kelompok3](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/114456394/e84b248e-33a9-4e0b-9025-32187b3715db)

Berdasarkan Flowchart Tersebut diketahui pada ketika memulai aplikasi tersebut pada tampilan dashboard terdapat 6 fitur  di dalamnya yang akan ditampilkan yaitu total responden, jumlah faktor yang dipermasalahkan dalam tiap faktornya, jumlah responden berdasarkan gender, rata rata umur responden total, dan rata-rata IPK (GPA) responden total. dimana dalam masing masing fitur tersebut akan ditampilkan dalam dashboard. Data yang ditampilkan tersebut diambil dari database responden. pada dashboard  di dalamnya terdapat button yang terdiri dari button list, home dan form tambahan.  Ketika memilih  menu button Responden nantinya akan diarahkan pada tampilan responden masuk. Pada tiap daftar responden tersebut apabila ditekan nantinya akan tampil detail hasil survei pada tiap respondennya.

## 1 - Tampilan Halaman Home
![Screenshot_1](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/114456394/d1069b76-a7e3-42c3-a65b-d3bad6864c4f)
![Screenshot_2](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/114456394/37496389-bdcf-4ccb-ba59-507005f64583)
![Screenshot_3](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/114456394/bfe74801-7db1-4e59-ba4d-e4a159b65296)
![Screenshot_4](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/114456394/cdad733b-1214-4580-a85c-a1c482b73daf)

Pada halaman home terdapat beberapa fitur didalamnya :
- Yang pertama fitur total responden yang menampilkan jumlah keseluruhan dari hasil survey yang  ada dapat dilihat pada gambar total keseluruhan responden sebesar 1005 orang. 
- Fitur gender yang berisikan jumlah responden berdasarkan jenis kelamin, dapat dilihat pada gambar gender male / laki-laki sebanyak 456 dan untuk female / perempuan sebanyak 549, pada fitur ini terdapat bagan pie chart yang akan menampilkan jumlah responden berdasarkan gender menggunakan chart yang akan dijelaskan lebih lanjut pada point 3. 
- Yang ketiga fitur Rata-rata responden yang berisikan besaran nilai untuk rata-rata umur dan nilai IPK/GPA, dari seluruh responden yang dari hasil survey mendapatkan nilai rata-rata umur berkisar 21,3 tahun dan rata-rata nilai IPK/GPA sebesar 2,2. 
- Fitur keempat yaitu fitur jumlah responden untuk tiap negara, pada hasil survey yang telah dilakukan didapatkannya 6 negara, dapat dilihat pada gambar dibawah ini negara yang paling banyak responden berasal dari negara Indonesia. Dibawah fitur ini terdapat bagan chart untuk genre yang berisikan pie chart untuk tiap faktor permasalahan dan bagan chart untuk nationality yang berisikan pie chart untuk responden tiap negaranya yang mana bagan-bagan tersebut akan dijelaskan lebih lanjut pada point 3.
- Fitur yang kelima yaitu fitur untuk menampilkan jumlah responden dari tiap faktor permasalahan. Dari data survey yang telah dilakukan, mendapatkan 11 faktor permasalahan yang ada. Pada halaman home tersebut telah menampilkan 11 faktor yang ada beserta dengan jumlah respondennya.

## 2 - Tampilan Halaman List
![Screenshot_5](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/114456394/77a852d6-d98b-4373-8e64-49fcd939e93c)
![Screenshot_6](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/114456394/e0dec8be-06c3-4a5a-88b9-786b7e9df95b)

Pada halaman list tertera daftar responden yang ada dan pada halaman ini untuk mengetahui detail dari respondent tersebut dapat menekan list responden yang ada yang nantinya akan muncul pop up yang berisikan detail dari respondent.

## 3 - Tampilan Halaman Detail Pie Chart
![Screenshot_7](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/114456394/b67ef434-40e5-4bc7-962e-9e42eff11754)
![Screenshot_8](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/114456394/7ec26343-2829-4d86-8590-a02b01ae32a6)
![Screenshot_9](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/114456394/3a239cb7-8fd9-4a74-b9a9-27836431ccd2)
Pada halaman detail pie chart terdapat visualisasi dari banyaknya data yang masuk pada responden tersebut. Dimana dalam implementasi visualisasi tersebut terdapat banyak data yang ditampilkan. Berdasar pada data yang ada, persentase besarnya responden berjenis kelamin laki-laki divisualisasikan dalam pie chart ini sebesar 45,37%. Sedangkan untuk responden berjenis kelamin perempuan setelah diakumulasikan di dapatkanlah sejumlah 54,63% merupakan responden perempuan. Tidak hanya itu saja visualisasi data terkait dengan genre pie chart disini juga diakumulasikan dalam persentase yang disesuaikan dengan jenisnya. seperti halnya pada data-data seperti academic support dan resources memegang persentase terbesar yaitu 23,48%, lalu atletic and sport 8,46%, career opportunities 8,86%, financial support 9,05%, health and well being support 5,27%, international student experiences 8,56%, online learning 8,96%, student affairs 3,28%, housing and transportation  6,37%, activities and traveling 3,98%, food and cantinies 13,73%.

Disamping kedua visualisasi data tersebut terdapat satu visualisasi data lagi yang dimana berkaitan dengan Country dari responden yang ada dimana mayoritas besar berasal dari indonesia dengan persentase sebesar 48,26%, kemudian Soudan 16,72%, France 13,23%, Mexico 14,33%, South Africa 2,59%, dan Yemen 4,88%. Melalui visualisasi tersebut memberikan kemudahan tersendiri untuk menganalisa dari besaran kuantitas data yang ada.

## Daftar Kontributor
| Anggota | Akun Github | Tugas |
| ------ | ------ | ------ |
| Ahmad Shodikin / 03 / 2141762132 | github.com/AhmadShodikinn | Front End |
| Clauria Dwi Putri Nabillah 06 / 2141762029 | github.com/ClauriaDwiPN | Pengolahan Data & Pelaporan |
| Edo Arya Hermawan / 07 / 2141762068 | github.com/edoaryah | Back End |
| Rendy Septian Pradana / 20 / 2141762018 | github.com/Rendyseptch | Dokumentasi & Pelaporan |

## Dokumentasi Kegiatan
![Dokumentasi_Kelompok3](https://github.com/edoaryah/Flutter-Laravel-SurveyApp/assets/114456394/a5c8eb7f-60c7-4102-a43e-1a01e7646108)
