
import 'package:flix/pages/homepage.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
     // home: GridTilePage(),

     theme:ThemeData(
    textTheme:  TextTheme(
      bodyLarge: TextStyle(),
      bodyMedium: TextStyle(),
      
    ).apply(
      bodyColor: Colors.white, 
      displayColor: Colors.white, 
      
    ),
  ),
     
    );
  }
}

// import 'package:flix/api/api_provider.dart';
// import 'package:flix/models/data_model.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Show App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: ShowListScreen(),
//     );
//   }
// }

// class ShowListScreen extends StatefulWidget {
//   @override
//   _ShowListScreenState createState() => _ShowListScreenState();
// }

// class _ShowListScreenState extends State<ShowListScreen> {
//   final PostDetails _postDetails = PostDetails();
//   late Future<List<Movie>> _moviesAndSeries;

//   @override
//   void initState() {
//     super.initState();
//     _moviesAndSeries = _postDetails.fetchMoviesAndSeries();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Movie and Series List'),
//       ),
//       body: FutureBuilder<List<Movie>>(
//         future: _moviesAndSeries,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 final movieOrSeries = snapshot.data![index];
//                 return ListTile(
//                   title: Text(movieOrSeries.title),
//                   subtitle: Text(movieOrSeries.year),
//                   // Add more UI elements to display movie/series details
//                 );
//               },
//             );
//           } else {
//             return Text('No data available.');
//           }
//         },
//       ),
//     );
//   }
// }
