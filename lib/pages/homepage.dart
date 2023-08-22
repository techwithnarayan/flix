import 'package:flix/api/api_provider.dart';
import 'package:flix/models/data_model.dart';
import 'package:flix/pages/gridtile_page.dart';
import 'package:flix/pages/search_page.dart';
import 'package:flix/pages/titleinfo_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PostDetails _postDetails = PostDetails();
  late Future<List<Movie>> _moviesAndSeries;

  @override
  void initState() {
    super.initState();
    _moviesAndSeries = _postDetails.fetchMoviesAndSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Colors.grey.shade900,
            Colors.grey,
            // Colors.white
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: FutureBuilder<List<Movie>>(
            future: _moviesAndSeries,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final List<Movie> allPosts = snapshot.data!;
                // Group the posts by category
                final Map<String, List<Movie>> postsByCategory = {};
                for (final post in allPosts) {
                  if (postsByCategory.containsKey(post.type)) {
                    postsByCategory[post.type]!.add(post);
                  } else {
                    postsByCategory[post.type] = [post];
                  }
                }
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchPage(searchdata: allPosts,)));
                          },
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      for (final category in postsByCategory.keys)
                        _buildSection(category, category, 200,
                            postsByCategory[category]!),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                );

                // return ListView.builder(
                //   itemCount: snapshot.data!.length,
                //   itemBuilder: (context, index) {
                //     final movieOrSeries = snapshot.data![index];
                //     return ListTile(
                //       title: Text(movieOrSeries.title),
                //       subtitle: Text(movieOrSeries.year),
                //       // Add more UI elements to display movie/series details
                //     );
                //   },
                // );
              } else {
                return Text('No data available.');
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
      String title, String type, double height, List<Movie> posts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //SizedBox(height: 130,),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          GridTilePage(category: type, posters: posts),
                    ),
                  );
                },
                child: Text(
                  "See All",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade300,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: height,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: posts.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TitleInfoPage(
                                data: posts[index],
                              )),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(posts[index].poster),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                    // height: 200,
                    width: 140,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/*

import 'package:flix/api/api_provider.dart';
import 'package:flix/model/data_model.dart';
import 'package:flix/pages/category_page.dart';
import 'package:flix/pages/titile_info.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final postDetails = PostDetails();
  late Future<List<Post>> _futurePosts;

  @override
  void initState() {
    super.initState();
    _futurePosts = postDetails.apicall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey.shade900,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder(
          future: _futurePosts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error ${snapshot.error}"),
              );
            } else {
              final List<Post> allPosts = snapshot.data!;
              // Group the posts by category
              final Map<String, List<Post>> postsByCategory = {};
              for (final post in allPosts) {
                if (postsByCategory.containsKey(post.type)) {
                  postsByCategory[post.type]!.add(post);
                } else {
                  postsByCategory[post.type] = [post];
                }
              }
              return Column(
                children: [
                  const SizedBox(height: 150),
                  for (final category in postsByCategory.keys)
                 
                    _buildSection(
                        category, category, 200, postsByCategory[category]!),
                        SizedBox(height: 50,),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildSection(
      String title, String category, double height, List<Post> posts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //SizedBox(height: 130,),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 20),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CategoryPage(category: category, posts: posts),
                    ),
                  );
                },
                child: const Text(
                  "See All",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: height,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: posts.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to Post Details Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TitleInfo(
                          info: posts[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(posts[index].poster),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    // height: 200,
                    width: 140,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
*/
