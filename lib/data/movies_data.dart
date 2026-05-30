import 'package:flickreview/models/review.dart';

import '../models/movies.dart';

var movieList = [
  Movie(
    id: 'fast-furious-2009',
    title: 'Fast & Furious',
    year: '2009',
    synopsis:
        'Dominic Toretto kembali ke Los Angeles dan bertemu lagi dengan Brian O\'Conner. '
        'Keduanya terpaksa bekerja sama untuk menjatuhkan kartel narkoba internasional.',
    genre: 'Action, Crime, Thriller',
    director: 'Justin Lin',
    duration: '1h 47m',
    type: 'Movie',
    trailerId: 'k98tBkRsGl4',
    posterUrl:
        'https://image.tmdb.org/t/p/w1280/lUtVoRukW7WNtUySwd8hWlByBds.jpg',
    imageUrls: [
      'https://image.tmdb.org/t/p/original/acktCBsLJcgEJsjTuyiQhJipCD6.jpg',
      'https://image.tmdb.org/t/p/original/jar6k3UmSyW0RA4ygti1jpHSKqn.jpg',
      'https://image.tmdb.org/t/p/original/vl4WP1C5J1UcW2qOF5QcGsvl5FR.jpg',
      'https://image.tmdb.org/t/p/original/A6v2dEyILory7n4Wx8W9RyuJmsF.jpg',
      'https://image.tmdb.org/t/p/original/eBJFaiVkOA4MkWBlgvanpPOsIdc.jpg',
    ],
    imdbRating: 6.5,
    rottenTomatoes: 28,
    flickReviewRating: 3.8,
    cast: [
      'Vin Diesel',
      'Paul Walker',
      'Michelle Rodriguez',
      'Jordana Brewster',
    ],
    reviews: [
      Review(
        reviewerName: "Aditya Pratama",
        profileImage: "https://i.pravatar.cc/150?img=12",
        rating: 3.8,
        shortReview: "Kembalinya nuansa balap jalanan.",
        fullReview:
            "Film ini membawa kembali nuansa balap jalanan yang sempat hilang dari seri "
            "Fast & Furious sebelumnya. Setelah beberapa film yang lebih berfokus pada "
            "balapan bergaya internasional dan cerita yang cenderung terpisah, Fast & "
            "Furious (2009) terasa seperti upaya untuk kembali ke akar franchise. Atmosfer "
            "balap ilegal, mobil-mobil modifikasi, serta ketegangan di jalanan kota kembali "
            "menjadi fokus utama yang cukup menyegarkan bagi para penggemar lama. "
            "Chemistry antara Dom Toretto dan Brian O’Conner terasa kuat dan natural, "
            "mengingat hubungan karakter mereka sudah dibangun sejak film pertama. "
            "Interaksi keduanya memberikan nuansa emosional yang lebih dalam, terutama "
            "dalam menggambarkan konflik masa lalu, rasa saling percaya, dan tujuan yang "
            "akhirnya sejalan. Meskipun alur cerita tergolong sederhana dan tidak terlalu "
            "kompleks, penyajiannya tetap efektif dalam menjaga ketegangan dan ritme film. "
            "Aksi kejar-kejaran mobil disajikan dengan cukup intens, didukung oleh editing "
            "yang cepat dan suara mesin yang memberikan sensasi balap yang realistis. "
            "Secara keseluruhan, film ini berhasil membangkitkan kembali identitas awal "
            "Fast & Furious sebagai film balap jalanan dengan sentuhan aksi dan emosi, "
            "meskipun masih memiliki beberapa kekurangan dari sisi kedalaman cerita.",
      ),
      Review(
        reviewerName: "Rizky Mahendra",
        profileImage: "https://i.pravatar.cc/150?img=13",
        rating: 4.0,
        shortReview: "Awal kebangkitan franchise.",
        fullReview:
            "Fast & Furious (2009) dapat dianggap sebagai titik awal kebangkitan franchise "
            "ini menuju arah yang lebih matang dan terarah. Film ini menyatukan kembali "
            "karakter-karakter utama yang sebelumnya terpisah, sehingga memberikan rasa "
            "kontinuitas yang kuat dengan film pertama. Kembalinya Dom dan Brian sebagai "
            "fokus utama cerita membuat film ini terasa lebih personal dan emosional "
            "dibandingkan pendahulunya. "
            "Aksi yang ditampilkan mengalami peningkatan signifikan, baik dari segi skala "
            "maupun intensitas. Adegan balapan dan kejar-kejaran mobil disusun dengan lebih "
            "serius dan penuh ketegangan, tidak hanya sebagai hiburan visual, tetapi juga "
            "sebagai bagian penting dari alur cerita. Unsur emosional mulai diperkuat, "
            "terutama dalam menggambarkan motif balas dendam, kesetiaan, dan hubungan antar "
            "karakter. "
            "Walaupun film ini belum sepenuhnya mencapai skala aksi spektakuler seperti "
            "sekuel-sekuel setelahnya, Fast & Furious (2009) berhasil meletakkan fondasi "
            "yang kuat untuk arah franchise ke depan. Film ini menunjukkan transisi dari "
            "sekadar film balap jalanan menjadi film aksi yang lebih luas, tanpa "
            "meninggalkan identitas utamanya. Dengan kombinasi aksi, emosi, dan nostalgia, "
            "film ini menjadi salah satu momen penting yang menandai kebangkitan Fast & "
            "Furious sebagai franchise global.",
      ),
    ],

    releaseDate: '3 April 2009',
    language: 'English',
    isFavorite: false,
  ),

  Movie(
    id: 'avatar-2009',
    title: 'Avatar',
    year: '2009',
    synopsis:
        'Jake Sully, seorang mantan marinir, menjalankan avatar Na\'vi di Pandora dan menemukan dirinya terjebak antara tugas militernya dan perlindungan planet tersebut.',
    genre: 'Sci-Fi, Adventure, Fantasy',
    director: 'James Cameron',
    duration: '2h 42m',
    type: 'Movie',
    trailerId: '5PSNL1qE6VY',
    posterUrl:
        'https://image.tmdb.org/t/p/w1280/gKY6q7SjCkAU6FqvqWybDYgUKIF.jpg',
    imageUrls: [
      'https://image.tmdb.org/t/p/original/Yc9q6QuWrMp9nuDm5R8ExNqbEq.jpg',
      'https://image.tmdb.org/t/p/original/8I37NtDffNV7AZlDa7uDvvqhovU.jpg',
      'https://image.tmdb.org/t/p/original/jlQJDD0L5ZojjlS0KYnApdO0n19.jpg',
      'https://image.tmdb.org/t/p/original/njjVFhLdNHhkb30AtNDTKtjwHna.jpg',
      'https://image.tmdb.org/t/p/original/bhdqWOXsDSNGTokJiTGCSr98XIC.jpg',
      'https://image.tmdb.org/t/p/original/55XziVCAYLOF0hAkpB01FtUF8fq.jpg',
    ],
    imdbRating: 7.9,
    rottenTomatoes: 82,
    flickReviewRating: 4.6,
    cast: [
      'Sam Worthington',
      'Zoe Saldana',
      'Sigourney Weaver',
      'Stephen Lang',
    ],
    reviews: [
      Review(
        reviewerName: "John Doe",
        profileImage: "https://i.pravatar.cc/150?img=1",
        rating: 4.0,
        shortReview: "Film yang sangat memukau secara visual...",
        fullReview:
            "Film ini merupakan sebuah pencapaian besar dalam dunia perfilman modern, "
            "terutama dari sisi visual dan teknologi sinematik yang digunakan. Sejak "
            "awal penayangan, penonton langsung disuguhkan dengan dunia Pandora yang "
            "terasa hidup, luas, dan penuh detail. James Cameron dengan sangat cermat "
            "membangun atmosfer dunia fiksi ini melalui perpaduan warna, pencahayaan, "
            "serta desain lingkungan yang konsisten dan memanjakan mata. Setiap elemen "
            "visual, mulai dari hutan bioluminesen hingga makhluk-makhluk unik, dirancang "
            "dengan tingkat ketelitian yang tinggi sehingga memberikan pengalaman menonton "
            "yang imersif dan sulit dilupakan. "
            "Di luar aspek visual, film ini juga memiliki alur cerita yang kuat dan "
            "emosional. Kisah perjalanan karakter utama disampaikan secara perlahan namun "
            "penuh makna, membuat penonton dapat memahami konflik batin yang dialami. "
            "Tema besar mengenai kemanusiaan, keserakahan, serta hubungan antara manusia "
            "dan alam disajikan dengan cara yang relevan dan mudah dipahami. Konflik antara "
            "kepentingan ekonomi dan pelestarian lingkungan menjadi inti cerita yang "
            "memberikan pesan moral yang cukup mendalam. "
            "Pengembangan karakter terasa solid, terutama dalam menggambarkan perubahan "
            "sudut pandang tokoh utama seiring berjalannya cerita. Interaksi antar karakter "
            "dibangun dengan baik sehingga emosi yang ditampilkan terasa natural dan tidak "
            "dipaksakan. Didukung oleh musik latar yang megah serta sinematografi yang "
            "konsisten, film ini berhasil menciptakan pengalaman sinema yang utuh. "
            "Secara keseluruhan, Avatar bukan hanya sekadar tontonan hiburan, tetapi juga "
            "sebuah karya yang menunjukkan bagaimana teknologi dapat digunakan untuk "
            "mendukung cerita yang kuat dan bermakna.",
      ),
      Review(
        reviewerName: "Sarah Kim",
        profileImage: "https://i.pravatar.cc/150?img=2",
        rating: 4.5,
        shortReview: "Cerita futuristik yang penuh emosi...",
        fullReview:
            "Avatar menghadirkan sebuah cerita futuristik yang tidak hanya berfokus pada "
            "keindahan visual, tetapi juga pada kedalaman emosi dan pesan yang ingin "
            "disampaikan kepada penonton. Dunia Pandora digambarkan sebagai ekosistem yang "
            "kompleks dan saling terhubung, di mana setiap makhluk hidup memiliki peran "
            "penting dalam menjaga keseimbangan alam. Detail ini membuat latar cerita "
            "terasa sangat hidup dan autentik, seolah-olah penonton benar-benar berada di "
            "dalam dunia tersebut. "
            "Penggunaan teknologi CGI dalam film ini dapat dikatakan sebagai salah satu "
            "yang paling revolusioner pada masanya. Setiap gerakan karakter, ekspresi "
            "wajah, hingga interaksi dengan lingkungan terlihat halus dan meyakinkan. "
            "Teknologi ini tidak hanya digunakan untuk menampilkan visual yang indah, "
            "tetapi juga untuk memperkuat penyampaian emosi dan cerita. Hal ini membuat "
            "penonton lebih mudah terhubung dengan karakter-karakter yang ada. "
            "Dari sisi narasi, alur cerita dibangun secara bertahap dengan ritme yang "
            "cukup seimbang. Konflik utama dikembangkan dengan baik, memberikan ruang bagi "
            "penonton untuk memahami motivasi setiap karakter. Klimaks cerita disajikan "
            "dengan intensitas tinggi dan berhasil memberikan kepuasan emosional. "
            "Pesan tentang pentingnya menjaga alam, menghargai perbedaan budaya, serta "
            "konsekuensi dari eksploitasi sumber daya disampaikan secara jelas tanpa "
            "terkesan menggurui. "
            "Secara keseluruhan, Avatar merupakan sebuah karya sinema yang berhasil "
            "menggabungkan teknologi, cerita, dan emosi dalam satu kesatuan yang kuat. "
            "Film ini layak disebut sebagai tonggak penting dalam perkembangan industri "
            "film dan masih sangat relevan untuk dinikmati oleh berbagai generasi "
            "penonton hingga saat ini.",
      ),
    ],

    releaseDate: '18 December 2009',
    language: 'English',
    isFavorite: false,
  ),

  Movie(
    id: 'inception-2010',
    title: 'Inception',
    year: '2010',
    synopsis:
        'Dom Cobb mencuri rahasia melalui mimpi, namun diberi misi sulit: menanamkan sebuah ide ke dalam pikiran target.',
    genre: 'Sci-Fi, Action, Thriller',
    director: 'Christopher Nolan',
    duration: '2h 28m',
    type: 'Movie',
    trailerId: 'YoHD9XEInc0',
    posterUrl:
        'https://image.tmdb.org/t/p/w1280/ljsZTbVsrQSqZgWeep2B1QiDKuh.jpg',
    imageUrls: [
      'https://image.tmdb.org/t/p/original/lvHNQSGdjxyW2n0rYCqb40NuCh4.jpg',
      'https://image.tmdb.org/t/p/original/56tSqd1kN6nU6sI1lfHO0p6mTS3.jpg',
      'https://image.tmdb.org/t/p/original/9vXCbwKnvnfarmm10OqlvC3SIoA.jpg',
      'https://image.tmdb.org/t/p/original/oSqBrxDe98mVUD3Aslxi4iewJdR.jpg',
      'https://image.tmdb.org/t/p/original/b9po61n5dvEgQ366SAbdh1Hdjz1.jpg',
    ],
    imdbRating: 8.8,
    rottenTomatoes: 87,
    flickReviewRating: 4.8,
    cast: ['Leonardo DiCaprio', 'Joseph Gordon-Levitt', 'Elliot Page'],
    reviews: [
      Review(
        reviewerName: "Dimas Prakoso",
        profileImage: "https://i.pravatar.cc/150?img=21",
        rating: 4.7,
        shortReview: "Konsep cerdas dengan eksekusi luar biasa.",
        fullReview:
            "Inception merupakan film fiksi ilmiah yang menghadirkan konsep cerita "
            "sangat cerdas dan kompleks, namun dikemas dengan cara yang tetap menarik "
            "dan menegangkan. Christopher Nolan berhasil membawa penonton masuk ke dalam "
            "dunia mimpi berlapis yang memiliki aturan, logika, dan konsekuensi tersendiri. "
            "Sejak awal film, penonton diajak untuk memahami bagaimana mimpi dapat "
            "dimanipulasi, dibentuk, bahkan dijadikan alat untuk mempengaruhi pikiran "
            "seseorang. Konsep ini menjadi fondasi kuat yang membedakan Inception dari "
            "film-film fiksi ilmiah pada umumnya. "
            "Karakter Dom Cobb digambarkan sebagai sosok yang kompleks dan penuh konflik "
            "batin. Trauma masa lalu dan rasa bersalah yang terus menghantuinya memberikan "
            "kedalaman emosional pada cerita. Leonardo DiCaprio berhasil menampilkan "
            "performa akting yang kuat dan meyakinkan, sehingga perjalanan emosional "
            "karakternya terasa nyata dan menyentuh. Hubungan antar karakter dibangun "
            "secara perlahan, namun efektif dalam mendukung alur cerita utama. "
            "Dari sisi visual, Inception menyajikan adegan-adegan ikonik yang sangat "
            "mengesankan, seperti kota yang terlipat dan pertarungan dalam kondisi tanpa "
            "gravitasi. Efek visual digunakan bukan sekadar untuk pamer teknologi, tetapi "
            "benar-benar mendukung cerita dan konsep dunia mimpi yang diciptakan. "
            "Didukung oleh musik latar karya Hans Zimmer yang intens dan atmosferik, film "
            "ini berhasil membangun ketegangan dari awal hingga akhir. Secara keseluruhan, "
            "Inception adalah film yang menantang pemikiran penonton dan memberikan "
            "pengalaman sinematik yang mendalam serta sulit dilupakan.",
      ),
      Review(
        reviewerName: "Nadia Putri",
        profileImage: "https://i.pravatar.cc/150?img=22",
        rating: 4.8,
        shortReview: "Film yang menantang logika dan emosi.",
        fullReview:
            "Inception adalah sebuah karya sinema yang tidak hanya menghibur, tetapi juga "
            "mengajak penonton untuk berpikir dan menafsirkan ceritanya secara mendalam. "
            "Film ini mengangkat ide tentang mimpi sebagai ruang tanpa batas, di mana "
            "realitas dapat dibentuk sesuai keinginan, namun tetap memiliki risiko yang "
            "besar. Setiap lapisan mimpi memiliki dinamika waktu yang berbeda, menciptakan "
            "ketegangan yang unik dan membuat penonton terus fokus mengikuti alur cerita. "
            "Keberanian film ini dalam menyajikan narasi non-linear patut diapresiasi. "
            "Alih-alih menyederhanakan cerita, Inception justru mempercayai kecerdasan "
            "penontonnya untuk memahami dan merangkai potongan-potongan cerita yang ada. "
            "Hal ini membuat film terasa semakin menarik untuk ditonton ulang, karena "
            "selalu ada detail-detail kecil yang baru disadari setelah pemutaran kedua "
            "atau ketiga. "
            "Selain aspek intelektual, film ini juga memiliki kekuatan emosional yang "
            "cukup besar. Konflik batin Dom Cobb menjadi jantung cerita yang memberikan "
            "alasan kuat bagi setiap aksi yang terjadi. Tema tentang kehilangan, "
            "penyesalan, dan keinginan untuk kembali kepada orang yang dicintai disampaikan "
            "dengan cara yang halus namun efektif. "
            "Dengan kombinasi cerita yang kompleks, visual yang inovatif, dan musik yang "
            "ikonik, Inception berhasil menetapkan standar baru bagi film fiksi ilmiah "
            "modern. Film ini bukan hanya sebuah tontonan, tetapi juga sebuah pengalaman "
            "berpikir yang membekas lama setelah kredit penutup bergulir.",
      ),
    ],

    releaseDate: '16 July 2010',
    language: 'English',
    isFavorite: false,
  ),

  Movie(
    id: 'fast-five-2011',
    title: 'Fast Five',
    year: '2011',
    synopsis:
        'Dom dan Brian melarikan diri ke Rio de Janeiro dan membentuk tim elit '
        'untuk melakukan perampokan terbesar dalam hidup mereka.',
    genre: 'Action, Crime, Thriller',
    director: 'Justin Lin',
    duration: '2h 10m',
    type: 'Movie',
    trailerId: 'vcn2GOuZCKI',
    posterUrl:
        'https://image.tmdb.org/t/p/w1280/gEfQjjQwY7fh5bI4GlG0RrBu7Pz.jpg',
    imageUrls: [
      'https://image.tmdb.org/t/p/original/krtWl2iNKAzoZZnVCgApBsH30sb.jpg',
      'https://image.tmdb.org/t/p/original/byGcS8vhbTmlPaYUUdywmmrnCNz.jpg',
      'https://image.tmdb.org/t/p/original/t7xqArwPIvOudTCzDLx1kRqT7i7.jpg',
      'https://image.tmdb.org/t/p/original/wQYeB6B1MBdu3ZTQNNFp2lVGsKE.jpg',
      'https://image.tmdb.org/t/p/original/13mM6x4mEECWVoBDT5FJMTrl4Kp.jpg',
    ],
    imdbRating: 7.3,
    rottenTomatoes: 77,
    flickReviewRating: 4.5,
    cast: [
      'Vin Diesel',
      'Paul Walker',
      'Dwayne Johnson',
      'Jordana Brewster',
      'Tyrese Gibson',
    ],
    reviews: [
      Review(
        reviewerName: "Naufal Akbar",
        profileImage: "https://i.pravatar.cc/150?img=14",
        rating: 4.6,
        shortReview: "Paling seru di masanya.",
        fullReview:
            "Fast Five sukses mengubah konsep balap menjadi heist action yang seru. "
            "Adegan brankas di Rio benar-benar ikonik.",
      ),
      Review(
        reviewerName: "Kevin Saputra",
        profileImage: "https://i.pravatar.cc/150?img=15",
        rating: 4.7,
        shortReview: "Skala aksi naik drastis.",
        fullReview:
            "Masuknya Dwayne Johnson memberi warna baru. "
            "Film ini terasa seperti film aksi kelas blockbuster.",
      ),
    ],
    releaseDate: '29 April 2011',
    language: 'English',
    isFavorite: false,
  ),

  Movie(
    id: 'drive-2011',
    title: 'Drive',
    year: '2011',
    synopsis:
        'Seorang stuntman pendiam bekerja sebagai pengemudi pelarian dan terjebak masalah besar ketika mencoba menolong tetangganya.',
    genre: 'Crime, Drama, Thriller',
    director: 'Nicolas Winding Refn',
    duration: '1h 40m',
    type: 'Movie',
    trailerId: 'OiTiKOy59o4',
    posterUrl:
        'https://image.tmdb.org/t/p/w1280/602vevIURmpDfzbnv5Ubi6wIkQm.jpg',
    imageUrls: [
      'https://image.tmdb.org/t/p/original/1oaLxMtdn47TWdaty8BwdU4oXhV.jpg',
      'https://image.tmdb.org/t/p/original/xVuAuVgwlCw2XceWLDAUymV1ZGq.jpg',
      'https://image.tmdb.org/t/p/original/3jZ7aGtq2x1xTe9KjiCyewZAlRH.jpg',
      'https://image.tmdb.org/t/p/original/iymDDg4upZWgpbSeiE1JCjsSPBs.jpg',
      'https://image.tmdb.org/t/p/original/bGmjA22fuODDnvNf9UZReI7PLlM.jpg',
    ],
    imdbRating: 7.8,
    rottenTomatoes: 93,
    flickReviewRating: 4.3,
    cast: ['Ryan Gosling', 'Carey Mulligan', 'Oscar Isaac'],
    reviews: [
      Review(
        reviewerName: "John Doe",
        profileImage: "https://i.pravatar.cc/150?img=1",
        rating: 4.0,
        shortReview: "Film yang sangat memukau secara visual...",
        fullReview:
            "Film yang sangat memukau secara visual dan memiliki cerita yang kuat. "
            "James Cameron berhasil membawa penonton ke dunia Pandora dengan imersif. "
            "Setiap adegan terlihat indah dan penuh detail...",
      ),
      Review(
        reviewerName: "Sarah Kim",
        profileImage: "https://i.pravatar.cc/150?img=2",
        rating: 4.5,
        shortReview: "Cerita futuristik yang penuh emosi...",
        fullReview:
            "Cerita futuristik yang penuh emosi, dipadukan dengan teknologi CGI yang "
            "sangat maju. Avatar adalah film revolusioner dalam industri film modern...",
      ),
    ],
    releaseDate: '16 September 2011',
    language: 'English',
    isFavorite: false,
  ),

  Movie(
    id: 'avengers-2012',
    title: 'The Avengers',
    year: '2012',
    synopsis:
        'Para pahlawan Marvel bersatu untuk menghentikan Loki yang ingin menaklukkan Bumi bersama pasukan alien.',
    genre: 'Action, Sci-Fi, Adventure',
    director: 'Joss Whedon',
    duration: '2h 23m',
    type: 'Movie',
    trailerId: '6ZfuNTqbHE8&t=2s',
    posterUrl:
        'https://image.tmdb.org/t/p/w1280/RYMX2wcKCBAr24UyPD7xwmjaTn.jpg',
    imageUrls: [
      'https://image.tmdb.org/t/p/original/kqn3odoKHHMnwbYKOXHQYFdk9PP.jpg',
      'https://image.tmdb.org/t/p/original/AcPvwyYOopP2jJAC5VYs2Y7xhWQ.jpg',
      'https://image.tmdb.org/t/p/original/kd2LiGBudibcrEGqAIV3bov0pii.jpg',
      'https://image.tmdb.org/t/p/original/gHLs7Fy3DzLmLsD4lmfqL55KGcl.jpg',
      'https://image.tmdb.org/t/p/original/86IbFy98QjRIqg6WanKYb9tXNbJ.jpg',
      'https://image.tm.db.org/t/p/original/yX8IlnW6qgJO50uSrd565Ni3KTj.jpg',
    ],
    imdbRating: 4.0,
    rottenTomatoes: 91,
    flickReviewRating: 4.4,
    cast: ['Robert Downey Jr.', 'Chris Evans', 'Scarlett Johansson'],
    reviews: [
      Review(
        reviewerName: "John Doe",
        profileImage: "https://i.pravatar.cc/150?img=1",
        rating: 4.0,
        shortReview: "Film yang sangat memukau secara visual...",
        fullReview:
            "Film yang sangat memukau secara visual dan memiliki cerita yang kuat. "
            "James Cameron berhasil membawa penonton ke dunia Pandora dengan imersif. "
            "Setiap adegan terlihat indah dan penuh detail...",
      ),
      Review(
        reviewerName: "Sarah Kim",
        profileImage: "https://i.pravatar.cc/150?img=2",
        rating: 4.5,
        shortReview: "Cerita futuristik yang penuh emosi...",
        fullReview:
            "Cerita futuristik yang penuh emosi, dipadukan dengan teknologi CGI yang "
            "sangat maju. Avatar adalah film revolusioner dalam industri film modern...",
      ),
    ],
    releaseDate: '4 May 2012',
    language: 'English',
    isFavorite: false,
  ),

  Movie(
    id: 'fast-furious-6',
    title: 'Fast & Furious 6',
    year: '2013',
    synopsis:
        'Dom dan timnya direkrut oleh Hobbs untuk menghentikan organisasi kriminal '
        'internasional yang dipimpin oleh Owen Shaw.',
    genre: 'Action, Crime, Thriller',
    director: 'Justin Lin',
    duration: '2h 10m',
    type: 'Movie',
    trailerId: 'oc_P11PNvRs',
    posterUrl:
        'https://image.tmdb.org/t/p/w1280/thSmnRdrzPBBospIOJjLZBReqzo.jpg',
    imageUrls: [
      'https://image.tmdb.org/t/p/original/daD0cpqD7nsRvqztpXzCFNijGIm.jpg',
      'https://image.tmdb.org/t/p/original/A0X2evOc46o7fC4Ee7sJSgmA4Z1.jpg',
      'https://image.tmdb.org/t/p/original/y3NSxcDV0PmP2tlTDFMg39LWh3q.jpg',
      'https://image.tmdb.org/t/p/original/mCYbtqCXodq0Am4PeyV4UfjIBgJ.jpg',
      'https://image.tmdb.org/t/p/original/f4P7kz239QXYIUDUwltUIUvgMY9.jpg',
      'https://image.tmdb.org/t/p/original/hvffMEHUZD87YXzjvtQqvkitZKl.jpg',
    ],
    imdbRating: 7.0,
    rottenTomatoes: 71,
    flickReviewRating: 4.2,
    cast: [
      'Vin Diesel',
      'Paul Walker',
      'Dwayne Johnson',
      'Michelle Rodriguez',
      'Luke Evans',
    ],
    reviews: [
      Review(
        reviewerName: "Fajar Nugroho",
        profileImage: "https://i.pravatar.cc/150?img=16",
        rating: 4.2,
        shortReview: "Aksi makin over the top.",
        fullReview:
            "Fast & Furious 6 menyajikan aksi yang makin tidak masuk akal, "
            "tapi tetap menghibur dari awal sampai akhir.",
      ),
      Review(
        reviewerName: "Bagas Wicaksono",
        profileImage: "https://i.pravatar.cc/150?img=17",
        rating: 4.0,
        shortReview: "Musuh yang solid.",
        fullReview:
            "Owen Shaw menjadi villain yang cukup kuat. "
            "Konflik personal Dom dan Letty terasa emosional.",
      ),
    ],
    releaseDate: '24 May 2013',
    language: 'English',
    isFavorite: false,
  ),

  Movie(
    id: 'gravity-2013',
    title: 'Gravity',
    year: '2013',
    synopsis:
        'Dua astronot berjuang untuk bertahan hidup setelah kecelakaan menghancurkan pesawat luar angkasa mereka.',
    genre: 'Sci-Fi, Thriller',
    director: 'Alfonso Cuarón',
    duration: '1h 31m',
    type: 'Movie',
    trailerId: 'OiTiKOy59o4',
    posterUrl:
        'https://image.tmdb.org/t/p/w1280/wmUeEacsFZzDndaeOtNNmy26rYJ.jpg',
    imageUrls: [
      'https://image.tmdb.org/t/p/original/npFPqZeHlEPOlLEpykP6kuSsi6v.jpg',
      'https://image.tmdb.org/t/p/original/ssXgDTycPTuxJKFEnUqogmtDgTP.jpg',
      'https://image.tmdb.org/t/p/original/ibG2711GsUcT4kg4vHoXiCLkOzs.jpg',
      'https://image.tmdb.org/t/p/original/131lKbxFcAvNALpWX9uodjqckLU.jpg',
      'https://image.tmdb.org/t/p/original/f0XAHvDrG0Di7ScyOvNynfNnsXX.jpg',
    ],
    imdbRating: 7.7,
    rottenTomatoes: 96,
    flickReviewRating: 4.1,
    cast: ['Sandra Bullock', 'George Clooney'],
    reviews: [
      Review(
        reviewerName: "John Doe",
        profileImage: "https://i.pravatar.cc/150?img=1",
        rating: 4.0,
        shortReview: "Film yang sangat memukau secara visual...",
        fullReview:
            "Film yang sangat memukau secara visual dan memiliki cerita yang kuat. "
            "James Cameron berhasil membawa penonton ke dunia Pandora dengan imersif. "
            "Setiap adegan terlihat indah dan penuh detail...",
      ),
      Review(
        reviewerName: "Sarah Kim",
        profileImage: "https://i.pravatar.cc/150?img=2",
        rating: 4.5,
        shortReview: "Cerita futuristik yang penuh emosi...",
        fullReview:
            "Cerita futuristik yang penuh emosi, dipadukan dengan teknologi CGI yang "
            "sangat maju. Avatar adalah film revolusioner dalam industri film modern...",
      ),
    ],
    releaseDate: '4 October 2013',
    language: 'English',
    isFavorite: false,
  ),

  Movie(
    id: 'interstellar-2014',
    title: 'Interstellar',
    year: '2014',
    synopsis:
        'Seorang mantan pilot NASA melakukan perjalanan melalui wormhole untuk mencari planet baru bagi umat manusia.',
    genre: 'Sci-Fi, Adventure, Drama',
    director: 'Christopher Nolan',
    duration: '2h 49m',
    type: 'Movie',
    trailerId: 'zSWdZVtXT7E',
    posterUrl:
        'https://image.tmdb.org/t/p/w1280/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
    imageUrls: [
      'https://image.tmdb.org/t/p/original/5XNQBqnBwPA9yT0jZ0p3s8bbLh0.jpg',
      'https://image.tmdb.org/t/p/original/ln2Gre4IYRhpjuGVybbtaF4CLo5.jpg',
      'https://image.tmdb.org/t/p/original/5C3RriLKkIAQtQMx85JLtu4rVI2.jpg',
      'https://image.tmdb.org/t/p/original/8sNiAPPYU14PUepFNeSNGUTiHW.jpg',
      'https://image.tmdb.org/t/p/original/65BTgbR7w8g5h8PlNwUgRVWqPyQ.jpg',
    ],
    imdbRating: 8.7,
    rottenTomatoes: 73,
    flickReviewRating: 4.9,
    cast: [
      'Matthew McConaughey',
      'Anne Hathaway',
      'Jessica Chastain',
      'Michael Caine',
    ],
    reviews: [
      Review(
        reviewerName: "John Doe",
        profileImage: "https://i.pravatar.cc/150?img=1",
        rating: 4.0,
        shortReview: "Film yang sangat memukau secara visual...",
        fullReview:
            "Film yang sangat memukau secara visual dan memiliki cerita yang kuat. "
            "James Cameron berhasil membawa penonton ke dunia Pandora dengan imersif. "
            "Setiap adegan terlihat indah dan penuh detail...",
      ),
      Review(
        reviewerName: "Sarah Kim",
        profileImage: "https://i.pravatar.cc/150?img=2",
        rating: 4.5,
        shortReview: "Cerita futuristik yang penuh emosi...",
        fullReview:
            "Cerita futuristik yang penuh emosi, dipadukan dengan teknologi CGI yang "
            "sangat maju. Avatar adalah film revolusioner dalam industri film modern...",
      ),
    ],
    releaseDate: '7 November 2014',
    language: 'English',
    isFavorite: false,
  ),

  Movie(
    id: 'furious-7',
    title: 'Furious 7',
    year: '2015',
    synopsis:
        'Dom dan timnya menjadi target balas dendam Deckard Shaw '
        'setelah kakaknya dikalahkan.',
    genre: 'Action, Crime, Thriller',
    director: 'James Wan',
    duration: '2h 17m',
    type: 'Movie',
    trailerId: 'Skpu5HaVkOc',
    posterUrl:
        'https://media.themoviedb.org/t/p/w440_and_h660_face/wurKlC3VKUgcfsn0K51MJYEleS2.jpg',
    imageUrls: [
      'https://image.tmdb.org/t/p/original/tinP0337hK5EfxPhsNo82ecqBVK.jpg',
      'https://image.tmdb.org/t/p/original/r8fA2ueh46HXoXD1eWbe1XXSZzD.jpg',
      'https://image.tmdb.org/t/p/original/1akgFOcpxwhS8YCgAkdVLBPGZXT.jpg',
      'https://image.tmdb.org/t/p/original/jsfmWdt0MXafgZpgRMD2A8fHyBX.jpg',
      'https://image.tmdb.org/t/p/original/vHDfcdgACT43iR1JKv5XqJAzOFQ.jpg',
      'https://image.tmdb.org/t/p/original/gyCHdpyPXmp7rqxE10nlImkzRo9.jpg',
      'https://image.tmdb.org/t/p/original/kbQ50VMUNc2EOpcc761DZIprWml.jpg',
      'https://image.tmdb.org/t/p/original/muY69LawUjeZtQ7l2cfhUbKZOY4.jpg',
    ],
    imdbRating: 7.1,
    rottenTomatoes: 82,
    flickReviewRating: 4.6,
    cast: [
      'Vin Diesel',
      'Paul Walker',
      'Jason Statham',
      'Dwayne Johnson',
      'Michelle Rodriguez',
    ],
    reviews: [
      Review(
        reviewerName: "Dimas Arya",
        profileImage: "https://i.pravatar.cc/150?img=18",
        rating: 4.8,
        shortReview: "Paling emosional.",
        fullReview:
            "Furious 7 bukan hanya tentang aksi, tapi juga perpisahan. "
            "Tribute untuk Paul Walker sangat menyentuh.",
      ),
      Review(
        reviewerName: "Andra Wijaya",
        profileImage: "https://i.pravatar.cc/150?img=19",
        rating: 4.7,
        shortReview: "Aksi dan emosi seimbang.",
        fullReview:
            "Adegan-adegannya gila, tapi ceritanya tetap punya hati. "
            "Salah satu film terbaik di franchise ini.",
      ),
    ],
    releaseDate: '3 April 2015',
    language: 'English',
    isFavorite: false,
  ),

  Movie(
    id: 'better-call-saul-2015',
    title: 'Better Call Saul',
    year: '2015',
    synopsis:
        'Kisah Jimmy McGill, pengacara kecil yang perlahan berubah menjadi Saul Goodman, tokoh penting di dunia Breaking Bad.',
    genre: 'Crime, Drama',
    director: 'Vince Gilligan & Peter Gould',
    duration: '6 seasons',
    type: 'Series',
    trailerId: 'HN4oydykJFc',
    posterUrl:
        'https://image.tmdb.org/t/p/w1280/fC2HDm5t0kHl7mTm7jxMR31b7by.jpg',
    imageUrls: [
      'https://image.tmdb.org/t/p/original/y1AD4sbw6mYNiiSFkW1nVZzz4Zn.jpg',
      'https://image.tmdb.org/t/p/original/viDThki0mlD4NDtCVGtLX6Ru44C.jpg',
      'https://image.tmdb.org/t/p/original/u5pPTiLMEvxaPtdhF2Wj6YTXI2h.jpg',
      'https://image.tmdb.org/t/p/original/egcNHq9PQDprPPTDlF3rys6WVy.jpg',
      'https://image.tmdb.org/t/p/original/dc1JPNkmqbIcfqao9LScW7AzwiT.jpg',
    ],
    imdbRating: 8.9,
    rottenTomatoes: 98,
    flickReviewRating: 4.9,
    cast: ['Bob Odenkirk', 'Rhea Seehorn', 'Jonathan Banks'],
    reviews: [
      Review(
        reviewerName: "John Doe",
        profileImage: "https://i.pravatar.cc/150?img=1",
        rating: 4.0,
        shortReview: "Film yang sangat memukau secara visual...",
        fullReview:
            "Film yang sangat memukau secara visual dan memiliki cerita yang kuat. "
            "James Cameron berhasil membawa penonton ke dunia Pandora dengan imersif. "
            "Setiap adegan terlihat indah dan penuh detail...",
      ),
      Review(
        reviewerName: "Sarah Kim",
        profileImage: "https://i.pravatar.cc/150?img=2",
        rating: 4.5,
        shortReview: "Cerita futuristik yang penuh emosi...",
        fullReview:
            "Cerita futuristik yang penuh emosi, dipadukan dengan teknologi CGI yang "
            "sangat maju. Avatar adalah film revolusioner dalam industri film modern...",
      ),
    ],
    releaseDate: '8 February 2015',
    language: 'English',
    isFavorite: false,
  ),

  Movie(
    id: 'la-la-land-2016',
    title: 'La La Land',
    year: '2016',
    synopsis:
        'Seorang musisi jazz dan aktris muda jatuh cinta sambil mengejar mimpi mereka di Los Angeles.',
    genre: 'Drama, Music, Romance',
    director: 'Damien Chazelle',
    duration: '2h 8m',
    type: 'Movie',
    trailerId: '0pdqf4P9MB8',
    posterUrl:
        'https://image.tmdb.org/t/p/w1280/uDO8zWDhfWwoFdKS4fzkUJt0Rf0.jpg',
    imageUrls: [
      'https://image.tmdb.org/t/p/original/sy8wZfYJ1yvXePBhSUXEom21OIW.jpg',
      'https://image.tmdb.org/t/p/original/17QOQENrIS5DvazwpqW6jrcWA1T.jpg',
      'https://image.tmdb.org/t/p/original/rVRtRE6HJ5xbdo5jd9aTT8tEVaF.jpg',
      'https://image.tmdb.org/t/p/original/nofXR1TN1vgGjdfnwGQwFaAWBaY.jpg',
      'https://image.tmdb.org/t/p/original/tlCBtqrhbPcuXVXoxmQ0AYfUstt.jpg',
    ],
    imdbRating: 4.0,
    rottenTomatoes: 91,
    flickReviewRating: 4.5,
    cast: ['Ryan Gosling', 'Emma Stone'],
    reviews: [
      Review(
        reviewerName: "John Doe",
        profileImage: "https://i.pravatar.cc/150?img=1",
        rating: 4.0,
        shortReview: "Film yang sangat memukau secara visual...",
        fullReview:
            "Film yang sangat memukau secara visual dan memiliki cerita yang kuat. "
            "James Cameron berhasil membawa penonton ke dunia Pandora dengan imersif. "
            "Setiap adegan terlihat indah dan penuh detail...",
      ),
      Review(
        reviewerName: "Sarah Kim",
        profileImage: "https://i.pravatar.cc/150?img=2",
        rating: 4.5,
        shortReview: "Cerita futuristik yang penuh emosi...",
        fullReview:
            "Cerita futuristik yang penuh emosi, dipadukan dengan teknologi CGI yang "
            "sangat maju. Avatar adalah film revolusioner dalam industri film modern...",
      ),
    ],
    releaseDate: '9 December 2016',
    language: 'English',
    isFavorite: false,
  ),

  Movie(
    id: 'fate-of-the-furious',
    title: 'The Fate of the Furious',
    year: '2017',
    synopsis:
        'Dom mengkhianati timnya setelah dipaksa bekerja oleh seorang teroris siber '
        'bernama Cipher.',
    genre: 'Action, Crime, Thriller',
    director: 'F. Gary Gray',
    duration: '2h 16m',
    type: 'Movie',
    trailerId: 'jeKBMdYaM3U',
    posterUrl:
        'https://image.tmdb.org/t/p/w1280/dImWM7GJqryWJO9LHa3XQ8DD5NH.jpg',
    imageUrls: [
      'https://image.tmdb.org/t/p/original/ovzdFld9HKxFpXvkJt86fkv2B2u.jpg',
      'https://image.tmdb.org/t/p/original/3IJ8kG8i84PncXkSovu0PaZQfjM.jpg',
      'https://image.tmdb.org/t/p/original/7Xhe8vnss2Pw8ZnT34KEDtetPHr.jpg',
      'https://image.tmdb.org/t/p/original/eSbOhGw07HQfUqMi2MDWHnW6fkt.jpg',
      'https://image.tmdb.org/t/p/original/hxGXL1LY1jLYD45TIjt7DcghZOu.jpg',
      'https://image.tmdb.org/t/p/original/xOL4K5ZZfa7bx54QbVlyE3P70eV.jpg',
    ],
    imdbRating: 6.6,
    rottenTomatoes: 67,
    flickReviewRating: 4.0,
    cast: [
      'Vin Diesel',
      'Dwayne Johnson',
      'Jason Statham',
      'Charlize Theron',
      'Michelle Rodriguez',
    ],
    reviews: [
      Review(
        reviewerName: "Ilham Fauzi",
        profileImage: "https://i.pravatar.cc/150?img=20",
        rating: 4.0,
        shortReview: "Dom jadi musuh?",
        fullReview:
            "Plot twist Dom menjadi antagonis cukup mengejutkan. "
            "Aksi di es Arktik jadi salah satu highlight.",
      ),
      Review(
        reviewerName: "Reza Firmansyah",
        profileImage: "https://i.pravatar.cc/150?img=21",
        rating: 3.9,
        shortReview: "Masih seru tapi mulai berlebihan.",
        fullReview:
            "Film ini tetap seru, namun hukum fisika mulai sering dilanggar. "
            "Cocok untuk hiburan tanpa berpikir berat.",
      ),
    ],
    releaseDate: '14 April 2017',
    language: 'English',
    isFavorite: false,
  ),

  Movie(
    id: 'blade-runner-2049-2017',
    title: 'Blade Runner 2049',
    year: '2017',
    synopsis:
        'Seorang blade runner baru menemukan rahasia yang berpotensi mengguncang sisa umat manusia.',
    genre: 'Sci-Fi, Thriller',
    director: 'Denis Villeneuve',
    duration: '2h 44m',
    type: 'Movie',
    trailerId: 'gCcx85zbxz4',
    posterUrl:
        'https://image.tmdb.org/t/p/w1280/gajva2L0rPYkEWjzgFlBXCAVBE5.jpg',
    imageUrls: [
      'https://image.tmdb.org/t/p/original/ilRyazdMJwN05exqhwK4tMKBYZs.jpg',
      'https://image.tmdb.org/t/p/original/h4eHTlkEF6e1oIzhIOhxHhITrz7.jpg',
      'https://image.tmdb.org/t/p/original/AplZ6nnfHQCfRpT1M9aQLi5QorZ.jpg',
      'https://image.tmdb.org/t/p/original/AdYJMNhcXVeqjRenSHP88oaLCaC.jpg',
      'https://image.tmdb.org/t/p/original/JyMCH2pCQ78SmC1vVWtCiQFpIZ.jpg',
    ],
    imdbRating: 4.0,
    rottenTomatoes: 88,
    flickReviewRating: 4.5,
    cast: ['Ryan Gosling', 'Harrison Ford', 'Ana de Armas'],
    reviews: [
      Review(
        reviewerName: "John Doe",
        profileImage: "https://i.pravatar.cc/150?img=1",
        rating: 4.0,
        shortReview: "Film yang sangat memukau secara visual...",
        fullReview:
            "Film yang sangat memukau secara visual dan memiliki cerita yang kuat. "
            "James Cameron berhasil membawa penonton ke dunia Pandora dengan imersif. "
            "Setiap adegan terlihat indah dan penuh detail...",
      ),
      Review(
        reviewerName: "Sarah Kim",
        profileImage: "https://i.pravatar.cc/150?img=2",
        rating: 4.5,
        shortReview: "Cerita futuristik yang penuh emosi...",
        fullReview:
            "Cerita futuristik yang penuh emosi, dipadukan dengan teknologi CGI yang "
            "sangat maju. Avatar adalah film revolusioner dalam industri film modern...",
      ),
    ],
    releaseDate: '6 October 2017',
    language: 'English',
    isFavorite: false,
  ),

  Movie(
    id: 'infinity-war-2018',
    title: 'Avengers: Infinity War',
    year: '2018',
    synopsis:
        'Para Avengers menghadapi Thanos yang berusaha menghapus separuh populasi alam semesta.',
    genre: 'Action, Sci-Fi',
    director: 'Anthony & Joe Russo',
    duration: '2h 29m',
    type: 'Movie',
    trailerId: '6ZfuNTqbHE8',
    posterUrl:
        'https://image.tmdb.org/t/p/w1280/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg',
    imageUrls: [
      'https://image.tmdb.org/t/p/original/2eVKyH2rQ6LxP3U5DBZiAsqQyMy.jpg',
      'https://image.tmdb.org/t/p/original/sbpTzyKkBedre1CjExJMNawEbHB.jpg',
      'https://image.tmdb.org/t/p/original/itSPvOwrQB41h0rGR8YHwquffuf.jpg',
      'https://image.tmdb.org/t/p/original/odmM7QtethJokb33LNTjZKxglvY.jpg',
      'https://image.tmdb.org/t/p/original/fjzjVPGJoHDIiK6cFvebcmhxDA7.jpg',
    ],
    imdbRating: 8.4,
    rottenTomatoes: 85,
    flickReviewRating: 4.7,
    cast: ['Robert Downey Jr.', 'Chris Hemsworth', 'Chris Evans'],
    reviews: [
      Review(
        reviewerName: "John Doe",
        profileImage: "https://i.pravatar.cc/150?img=1",
        rating: 4.0,
        shortReview: "Film yang sangat memukau secara visual...",
        fullReview:
            "Film yang sangat memukau secara visual dan memiliki cerita yang kuat. "
            "James Cameron berhasil membawa penonton ke dunia Pandora dengan imersif. "
            "Setiap adegan terlihat indah dan penuh detail...",
      ),
      Review(
        reviewerName: "Sarah Kim",
        profileImage: "https://i.pravatar.cc/150?img=2",
        rating: 4.5,
        shortReview: "Cerita futuristik yang penuh emosi...",
        fullReview:
            "Cerita futuristik yang penuh emosi, dipadukan dengan teknologi CGI yang "
            "sangat maju. Avatar adalah film revolusioner dalam industri film modern...",
      ),
    ],
    releaseDate: '27 April 2018',
    language: 'English',
    isFavorite: false,
  ),

  Movie(
    id: 'joker-2019',
    title: 'Joker',
    year: '2019',
    synopsis:
        'Arthur Fleck, seorang komedian gagal, mengalami tekanan hidup yang mendorongnya menjadi Joker.',
    genre: 'Crime, Drama, Thriller',
    director: 'Todd Phillips',
    duration: '2h 2m',
    type: 'Movie',
    trailerId: 'zAGVQLHvwOY',
    posterUrl:
        'https://image.tmdb.org/t/p/w1280/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg',
    imageUrls: [
      'https://image.tmdb.org/t/p/original/vu5Mv3CXlz5np1breEsKSUA2YX1.jpg',
      'https://image.tmdb.org/t/p/original/M5Kof2aW1giTZjS0BTdOCWVjVS.jpg',
      'https://image.tmdb.org/t/p/original/e89BFT5P8baD1lE6RqljYCa76Ms.jpg',
      'https://image.tmdb.org/t/p/original/1JlbnzFqp0KQBquCvSmoeWMe274.jpg',
      'https://image.tmdb.org/t/p/original/n6bUvigpRFqSwmPp1m2YADdbRBc.jpg',
    ],
    imdbRating: 8.4,
    rottenTomatoes: 69,
    flickReviewRating: 4.6,
    cast: ['Joaquin Phoenix', 'Robert De Niro'],
    reviews: [
      Review(
        reviewerName: "John Doe",
        profileImage: "https://i.pravatar.cc/150?img=1",
        rating: 4.0,
        shortReview: "Film yang sangat memukau secara visual...",
        fullReview:
            "Film yang sangat memukau secara visual dan memiliki cerita yang kuat. "
            "James Cameron berhasil membawa penonton ke dunia Pandora dengan imersif. "
            "Setiap adegan terlihat indah dan penuh detail...",
      ),
      Review(
        reviewerName: "Sarah Kim",
        profileImage: "https://i.pravatar.cc/150?img=2",
        rating: 4.5,
        shortReview: "Cerita futuristik yang penuh emosi...",
        fullReview:
            "Cerita futuristik yang penuh emosi, dipadukan dengan teknologi CGI yang "
            "sangat maju. Avatar adalah film revolusioner dalam industri film modern...",
      ),
    ],
    releaseDate: '4 October 2019',
    language: 'English',
    isFavorite: false,
  ),

  Movie(
    id: 'tenet-2020',
    title: 'Tenet',
    year: '2020',
    synopsis:
        'Seorang agen tanpa nama menggunakan inversi waktu untuk mencegah bencana global.',
    genre: 'Sci-Fi, Action',
    director: 'Christopher Nolan',
    duration: '2h 30m',
    type: 'Movie',
    trailerId: 'AZGcmvrTX9M',
    posterUrl:
        'https://image.tmdb.org/t/p/w1280/aCIFMriQh8rvhxpN1IWGgvH0Tlg.jpg',
    imageUrls: [
      'https://image.tmdb.org/t/p/original/7BYtnXUfweV6EryNYDpZFeS31Ia.jpg',
      'https://image.tmdb.org/t/p/original/9mXKnIgDVxSqRvg89HX98cXxaN5.jpg',
      'https://image.tmdb.org/t/p/original/ojWwXilVkFcuTrjqwMhLgEUvwHg.jpg',
      'https://image.tmdb.org/t/p/original/62kBisTm7o2rLkyJnNt20CcnrGp.jpg',
      'https://image.tmdb.org/t/p/original/bY7rJeBchIW4wSltkyPG86uhKhb.jpg',
    ],
    imdbRating: 7.3,
    rottenTomatoes: 69,
    flickReviewRating: 4.2,
    cast: ['John David Washington', 'Robert Pattinson'],
    reviews: [
      Review(
        reviewerName: "John Doe",
        profileImage: "https://i.pravatar.cc/150?img=1",
        rating: 4.0,
        shortReview: "Film yang sangat memukau secara visual...",
        fullReview:
            "Film yang sangat memukau secara visual dan memiliki cerita yang kuat. "
            "James Cameron berhasil membawa penonton ke dunia Pandora dengan imersif. "
            "Setiap adegan terlihat indah dan penuh detail...",
      ),
      Review(
        reviewerName: "Sarah Kim",
        profileImage: "https://i.pravatar.cc/150?img=2",
        rating: 4.5,
        shortReview: "Cerita futuristik yang penuh emosi...",
        fullReview:
            "Cerita futuristik yang penuh emosi, dipadukan dengan teknologi CGI yang "
            "sangat maju. Avatar adalah film revolusioner dalam industri film modern...",
      ),
    ],
    releaseDate: '3 September 2020',
    language: 'English',
    isFavorite: false,
  ),

  Movie(
    id: 'f9',
    title: 'F9: The Fast Saga',
    year: '2021',
    synopsis:
        'Dom menghadapi masa lalunya ketika adik kandungnya, Jakob Toretto, '
        'muncul sebagai ancaman baru.',
    genre: 'Action, Adventure, Thriller',
    director: 'Justin Lin',
    duration: '2h 23m',
    type: 'Movie',
    trailerId: 'aSiDu3Ywi8E',
    posterUrl:
        'https://image.tmdb.org/t/p/w1280/deEmLILTPejEb6OGsXRJ5MCvyDW.jpg',
    imageUrls: [
      'https://image.tmdb.org/t/p/original/4epzcO9HGbfc8BUJT0oNkL3rmCO.jpg',
      'https://image.tmdb.org/t/p/original/AgJtAH1YJ98jhaURmC6PozjrtIU.jpg',
      'https://image.tmdb.org/t/p/original/jQzhRRNc0kCBLXjszhRNed2xeaF.jpg',
      'https://image.tmdb.org/t/p/original/yTr7nzVZvVe4plVTySwZUqC1ob2.jpg',
      'https://image.tmdb.org/t/p/original/cOTSbix9ctmh8szLbKZOneaF9qj.jpg',
    ],
    imdbRating: 5.2,
    rottenTomatoes: 59,
    flickReviewRating: 3.6,
    cast: [
      'Vin Diesel',
      'John Cena',
      'Michelle Rodriguez',
      'Tyrese Gibson',
      'Ludacris',
    ],
    reviews: [
      Review(
        reviewerName: "Yoga Prakoso",
        profileImage: "https://i.pravatar.cc/150?img=22",
        rating: 3.6,
        shortReview: "Keluarga adalah segalanya.",
        fullReview:
            "Cerita tentang masa lalu Dom cukup menarik, "
            "meski aksi terasa semakin absurd.",
      ),
      Review(
        reviewerName: "Arief Ramadhan",
        profileImage: "https://i.pravatar.cc/150?img=23",
        rating: 3.7,
        shortReview: "Hiburan murni.",
        fullReview:
            "F9 adalah film yang tidak perlu logika, "
            "cukup duduk dan nikmati ledakan serta kejar-kejarannya.",
      ),
    ],
    releaseDate: '25 June 2021',
    language: 'English',
    isFavorite: false,
  ),

  Movie(
    id: 'dune-2021',
    title: 'Dune',
    year: '2021',
    synopsis:
        'Paul Atreides harus menghadapi konflik besar di planet gurun Arrakis demi masa depan keluarganya.',
    genre: 'Sci-Fi, Adventure',
    director: 'Denis Villeneuve',
    duration: '2h 35m',
    type: 'Movie',
    trailerId: 'n9xhJrPXop4',
    posterUrl:
        'https://image.tmdb.org/t/p/w1280/d5NXSklXo0qyIYkgV94XAgMIckC.jpg',
    imageUrls: [
      'https://image.tmdb.org/t/p/original/h3HsfV8Kn9Sz2QWUYYdP5ya23hx.jpg',
      'https://image.tmdb.org/t/p/original/xS0g3s4blsiPmtpjjb7chFjI1ip.jpg',
      'https://image.tmdb.org/t/p/original/bpeGvYm8VBNqrw5EXcvrimWMCR4.jpg',
      'https://image.tmdb.org/t/p/original/zsh6s0BLDFPpnGATiqa5TId0ROP.jpg',
      'https://image.tmdb.org/t/p/original/gUkOqTnzUWiUZuL2HPVhY7YmjJW.jpg',
    ],
    imdbRating: 4.0,
    rottenTomatoes: 83,
    flickReviewRating: 4.6,
    cast: ['Timothée Chalamet', 'Zendaya'],
    reviews: [
      Review(
        reviewerName: "John Doe",
        profileImage: "https://i.pravatar.cc/150?img=1",
        rating: 4.0,
        shortReview: "Film yang sangat memukau secara visual...",
        fullReview:
            "Film yang sangat memukau secara visual dan memiliki cerita yang kuat. "
            "James Cameron berhasil membawa penonton ke dunia Pandora dengan imersif. "
            "Setiap adegan terlihat indah dan penuh detail...",
      ),
      Review(
        reviewerName: "Sarah Kim",
        profileImage: "https://i.pravatar.cc/150?img=2",
        rating: 4.5,
        shortReview: "Cerita futuristik yang penuh emosi...",
        fullReview:
            "Cerita futuristik yang penuh emosi, dipadukan dengan teknologi CGI yang "
            "sangat maju. Avatar adalah film revolusioner dalam industri film modern...",
      ),
    ],
    releaseDate: '22 October 2021',
    language: 'English',
    isFavorite: false,
  ),

  Movie(
    id: 'avatar2-2022',
    title: 'Avatar: The Way of Water',
    year: '2022',
    synopsis:
        'Keluarga Sully menghadapi ancaman manusia baru yang memaksa mereka menjelajahi wilayah air Pandora.',
    genre: 'Sci-Fi, Adventure, Fantasy',
    director: 'James Cameron',
    duration: '3h 12m',
    type: 'Movie',
    trailerId: 'd9MyW72ELq0',
    posterUrl:
        'https://image.tmdb.org/t/p/w1280/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg',
    imageUrls: [
      'https://image.tmdb.org/t/p/original/6zHiQ8UlMMBLopNBgZyWohEeNLt.jpg',
      'https://image.tmdb.org/t/p/original/am8Zbct7hbZYGzet3Ub1Sa9Xskb.jpg',
      'https://image.tmdb.org/t/p/original/198vrF8k7mfQ4FjDJsBmdQcaiyq.jpg',
      'https://image.tmdb.org/t/p/original/5Aym0qCOh1D7ctZxf5vuYbTQTAa.jpg',
      'https://image.tmdb.org/t/p/original/zaapQ1zjKe2BGhhowh5pM251Gpl.jpg',
      'https://image.tmdb.org/t/p/original/5gPQKfFJnl8d1edbkOzKONo4mnr.jpg',
      'https://image.tmdb.org/t/p/original/4BJ9SQ22V3re0SSbco2IEvn98Dq.jpg',
      'https://image.tmdb.org/t/p/original/tpEljdxToj89U9THRFEcb6mlE6i.jpg',
    ],
    imdbRating: 7.6,
    rottenTomatoes: 76,
    flickReviewRating: 4.4,
    cast: ['Sam Worthington', 'Zoe Saldana', 'Sigourney Weaver'],
    reviews: [
      Review(
        reviewerName: "John Doe",
        profileImage: "https://i.pravatar.cc/150?img=1",
        rating: 4.0,
        shortReview: "Film yang sangat memukau secara visual...",
        fullReview:
            "Film yang sangat memukau secara visual dan memiliki cerita yang kuat. "
            "James Cameron berhasil membawa penonton ke dunia Pandora dengan imersif. "
            "Setiap adegan terlihat indah dan penuh detail...",
      ),
      Review(
        reviewerName: "Sarah Kim",
        profileImage: "https://i.pravatar.cc/150?img=2",
        rating: 4.5,
        shortReview: "Cerita futuristik yang penuh emosi...",
        fullReview:
            "Cerita futuristik yang penuh emosi, dipadukan dengan teknologi CGI yang "
            "sangat maju. Avatar adalah film revolusioner dalam industri film modern...",
      ),
    ],
    releaseDate: '16 December 2022',
    language: 'English',
    isFavorite: false,
  ),

  Movie(
    id: 'fast-x',
    title: 'Fast X',
    year: '2023',
    synopsis:
        'Dom Toretto dan keluarganya menghadapi ancaman paling mematikan dari masa lalu '
        'yang berusaha menghancurkan segalanya.',
    genre: 'Action, Crime, Thriller',
    director: 'Louis Leterrier',
    duration: '2h 21m',
    type: 'Movie',
    trailerId: '32RAq6JzY-w',
    posterUrl:
        'https://image.tmdb.org/t/p/w1280/fiVW06jE7z9YnO4trhaMEdclSiC.jpg',
    imageUrls: [
      'https://image.tmdb.org/t/p/original/e2Jd0sYMCe6qvMbswGQbM0Mzxt0.jpg',
      'https://image.tmdb.org/t/p/original/xPrwx07hpuPaQ5NGg5doB6RlDIM.jpg',
      'https://image.tmdb.org/t/p/original/4t0oBFrJyweYPt0hocW6RUa0b6H.jpg',
      'https://image.tmdb.org/t/p/original/rWChG4k7aVhALZrIZ7IVAmXUMzn.jpg',
      'https://image.tmdb.org/t/p/original/hgOvm4Vpa9PzV3hdndhAJzLrVKQ.jpg',
    ],
    imdbRating: 5.8,
    rottenTomatoes: 56,
    flickReviewRating: 3.9,
    cast: [
      'Vin Diesel',
      'Jason Momoa',
      'Michelle Rodriguez',
      'Tyrese Gibson',
      'Ludacris',
    ],
    reviews: [
      Review(
        reviewerName: "Raka Santosa",
        profileImage: "https://i.pravatar.cc/150?img=24",
        rating: 3.9,
        shortReview: "Villain yang mencuri perhatian.",
        fullReview:
            "Jason Momoa tampil mencolok sebagai villain yang unik. "
            "Fast X terasa seperti pembuka menuju konflik besar.",
      ),
      Review(
        reviewerName: "Hendra Kurniawan",
        profileImage: "https://i.pravatar.cc/150?img=25",
        rating: 4.0,
        shortReview: "Menuju klimaks franchise.",
        fullReview:
            "Ceritanya terasa menggantung, tapi aksi dan skala film "
            "tetap terasa masif dan menghibur.",
      ),
    ],
    releaseDate: '19 May 2023',
    language: 'English',
    isFavorite: false,
  ),

  Movie(
    id: 'oppenheimer-2023',
    title: 'Oppenheimer',
    year: '2023',
    synopsis:
        'J. Robert Oppenheimer memimpin proyek pembuatan bom atom pertama yang mengubah sejarah dunia.',
    genre: 'Biography, Drama, History',
    director: 'Christopher Nolan',
    duration: '3h 0m',
    type: 'Movie',
    trailerId: 'uYPbbksJxIg',
    posterUrl:
        'https://image.tmdb.org/t/p/w1280/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg',
    imageUrls: [
      'https://image.tmdb.org/t/p/original/ycnO0cjsAROSGJKuMODgRtWsHQw.jpg',
      'https://image.tmdb.org/t/p/original/8ohejkcQkNgkJgLn71Ws6Kd35g0.jpg',
      'https://image.tmdb.org/t/p/original/kMa1TSDj76zTSleXE7xsuZ4s3i0.jpg',
      'https://image.tmdb.org/t/p/original/zUObcYmP3F86mq61oNbtZz4tRjT.jpg',
      'https://image.tmdb.org/t/p/original/zpkUscxB4Is9HMbrSkCoWHRIGOw.jpg',
    ],
    imdbRating: 8.8,
    rottenTomatoes: 93,
    flickReviewRating: 4.8,
    cast: ['Cillian Murphy', 'Emily Blunt', 'Robert Downey Jr.'],
    reviews: [
      Review(
        reviewerName: "John Doe",
        profileImage: "https://i.pravatar.cc/150?img=1",
        rating: 4.0,
        shortReview: "Film yang sangat memukau secara visual...",
        fullReview:
            "Film yang sangat memukau secara visual dan memiliki cerita yang kuat. "
            "James Cameron berhasil membawa penonton ke dunia Pandora dengan imersif. "
            "Setiap adegan terlihat indah dan penuh detail...",
      ),
      Review(
        reviewerName: "Sarah Kim",
        profileImage: "https://i.pravatar.cc/150?img=2",
        rating: 4.5,
        shortReview: "Cerita futuristik yang penuh emosi...",
        fullReview:
            "Cerita futuristik yang penuh emosi, dipadukan dengan teknologi CGI yang "
            "sangat maju. Avatar adalah film revolusioner dalam industri film modern...",
      ),
    ],
    releaseDate: '21 July 2023',
    language: 'English',
    isFavorite: false,
  ),

  Movie(
    id: 'dune2-2024',
    title: 'Dune: Part Two',
    year: '2024',
    synopsis:
        'Paul Atreides melanjutkan perjuangannya melawan House Harkonnen untuk membalas pengkhianatan dan menyelamatkan Arrakis.',
    genre: 'Sci-Fi, Adventure',
    director: 'Denis Villeneuve',
    duration: '2h 46m',
    type: 'Movie',
    trailerId: '_YUzQa_1RCE',
    posterUrl:
        'https://image.tmdb.org/t/p/w1280/uOYAbN3F5n3ne8TzWjzVEvQ7XGX.jpg',
    imageUrls: [
      'https://image.tmdb.org/t/p/original/3jAmIiF931QuBAZ93OOgjaucNa7.jpg',
      'https://image.tmdb.org/t/p/original/e5DbpCYx5wtoEJKOoXBbSsOOy6f.jpg',
      'https://image.tmdb.org/t/p/original/lDrlJzuLdg2bKcvek4ZpmN3Lo47.jpg',
      'https://image.tmdb.org/t/p/original/ylkdrn23p3gQcHx7ukIfuy2CkTE.jpg',
      'https://image.tmdb.org/t/p/original/uUVQCwBsWdQDMssXv1TRvYKnXgS.jpg',
    ],
    imdbRating: 8.5,
    rottenTomatoes: 92,
    flickReviewRating: 4.7,
    cast: ['Timothée Chalamet', 'Zendaya', 'Austin Butler'],
    reviews: [
      Review(
        reviewerName: "John Doe",
        profileImage: "https://i.pravatar.cc/150?img=1",
        rating: 4.0,
        shortReview: "Film yang sangat memukau secara visual...",
        fullReview:
            "Film yang sangat memukau secara visual dan memiliki cerita yang kuat. "
            "James Cameron berhasil membawa penonton ke dunia Pandora dengan imersif. "
            "Setiap adegan terlihat indah dan penuh detail...",
      ),
      Review(
        reviewerName: "Sarah Kim",
        profileImage: "https://i.pravatar.cc/150?img=2",
        rating: 4.5,
        shortReview: "Cerita futuristik yang penuh emosi...",
        fullReview:
            "Cerita futuristik yang penuh emosi, dipadukan dengan teknologi CGI yang "
            "sangat maju. Avatar adalah film revolusioner dalam industri film modern...",
      ),
    ],
    releaseDate: '3 March 2024',
    language: 'English',
    isFavorite: false,
  ),

  Movie(
    id: 'avatar3-2025',
    title: 'Avatar: Fire and Ash',
    year: '2025',
    synopsis:
        'Kisah keluarga Sully berlanjut ketika mereka menghadapi suku Na\'vi baru serta ancaman manusia yang semakin berbahaya.',
    genre: 'Sci-Fi, Adventure, Fantasy',
    director: 'James Cameron',
    duration: 'TBA',
    type: 'Movie',
    trailerId: 'nb_fFj_0rq8',
    posterUrl:
        'https://image.tmdb.org/t/p/w1280/gDVgC9jd917NdAcqBdRRDUYi4Tq.jpg',
    imageUrls: [
      'https://image.tmdb.org/t/p/original/pN3eaCl3sqwrerU8UNdp40F2mK0.jpg',
      'https://image.tmdb.org/t/p/original/wvsZk5fFvjXKitaWQ2KlYeAq4N3.jpg',
      'https://image.tmdb.org/t/p/original/uqziqEaez7OlZixrPj8a861CqrJ.jpg',
      'https://image.tmdb.org/t/p/original/jMj0HmnVU2pVEpr3gCNwld3z3cL.jpg',
      'https://image.tmdb.org/t/p/original/ptGiXwFXY3dyxp0ySHu1m6ZnoVl.jpg',
      'https://image.tmdb.org/t/p/original/mLQW73s2Z7ztgLw3feMIgAcqnmy.jpg',
      'https://image.tmdb.org/t/p/original/zW5mplW43kuUpsYwkHHZ8jc9sdi.jpg',
    ],
    imdbRating: 0.0,
    rottenTomatoes: 0,
    flickReviewRating: 0,
    cast: ['Sam Worthington', 'Zoe Saldana', 'Sigourney Weaver'],
    reviews: [
      Review(
        reviewerName: "John Doe",
        profileImage: "https://i.pravatar.cc/150?img=1",
        rating: 4.0,
        shortReview: "Film yang sangat memukau secara visual...",
        fullReview:
            "Film yang sangat memukau secara visual dan memiliki cerita yang kuat. "
            "James Cameron berhasil membawa penonton ke dunia Pandora dengan imersif. "
            "Setiap adegan terlihat indah dan penuh detail...",
      ),
      Review(
        reviewerName: "Sarah Kim",
        profileImage: "https://i.pravatar.cc/150?img=2",
        rating: 4.5,
        shortReview: "Cerita futuristik yang penuh emosi...",
        fullReview:
            "Cerita futuristik yang penuh emosi, dipadukan dengan teknologi CGI yang "
            "sangat maju. Avatar adalah film revolusioner dalam industri film modern...",
      ),
    ],
    releaseDate: '19 December 2025',
    language: 'English',
    isFavorite: false,
  ),
];
