// import 'package:flix/models/data_model.dart';
// import 'package:flutter/material.dart';

// class SearchPage extends StatefulWidget {
//   final List<Movie> searchdata;
//    const SearchPage({super.key, required this.searchdata});

//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Search page")),
//       body: Column(
// children: [
//   Expanded(
//     child: ListView.builder(
//       itemCount: widget.searchdata.length,
      
//       itemBuilder: (context, index){
//       return ListTile(
//         //leading: ,
//         title: Text(widget.searchdata[index].title),
  
//       );
//     }),
//   )
// ],
//       ),
//     );
//   }
// }



import 'dart:ffi';

import 'package:flix/models/data_model.dart';
import 'package:flix/pages/titleinfo_page.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final List<Movie> searchdata;
  const SearchPage({super.key, required this.searchdata});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  List<Movie> _filteredMovies = [];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Filter movies based on the search query
      setState(() {
        _filteredMovies = widget.searchdata
            .where((movie) =>
                movie.title.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();
      });
    }
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _searchQuery = '';
      _filteredMovies.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      //appBar: AppBar(title: Text("Search page")),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                         height: 55,
                         width: 50,
                          decoration: BoxDecoration( color: Colors.white, borderRadius: BorderRadius.circular(10)),
                          child:  Icon(Icons.arrow_back)),
                ),
              ),
            ),
                    SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _searchController,
                  //onTap: _clearSearch, // Clear the search query when tapped
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                       //return 'Please enter a search query';
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a search query')));
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 15, left: 10, bottom: 15, right: 10),
                   hintStyle: TextStyle(color: Colors.white, fontSize: 20, letterSpacing: 2, fontWeight: FontWeight.w600),
                    fillColor: Colors.grey.shade700,
                    filled: true,
                    suffixIcon: GestureDetector(
                      onTap: _clearSearch,
                      child: Icon(Icons.close_outlined, color: Colors.red,)),
                    hintText: 'Search',
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16),borderSide: BorderSide(color: Colors.grey.shade500)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade700)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade700)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            
InkWell(
  onTap: _submitForm,
borderRadius: BorderRadius.circular(10),  
  child: Container(
    alignment: Alignment.center,
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10) ,color: Colors.teal,),
  height: 50,
  width: 150,
 
  child: Text("Search Now", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
),),
  SizedBox(height: 50,),




            Expanded(
              child: _filteredMovies.isNotEmpty
                  ? ListView.builder(
                    physics: BouncingScrollPhysics(),
                      itemCount: _filteredMovies.length,
                      itemBuilder: (context, index) {
                        return  Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade600),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> TitleInfoPage(data: widget.searchdata[index])));
                              },
                              leading: Container(
                                
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(image: NetworkImage(_filteredMovies[index].poster, ),fit: BoxFit.cover,))),
                              title: Text(_filteredMovies[index].title, style: TextStyle(color: Colors.white),),
                              subtitle:Text(_filteredMovies[index].year, style: TextStyle(color: Colors.white),) ,
                            ),
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                    physics: BouncingScrollPhysics(),
                      itemCount: widget.searchdata.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade600),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> TitleInfoPage(data: widget.searchdata[index])));
                              },
                              leading: Container(
                                
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(image: NetworkImage(widget.searchdata[index].poster, ),fit: BoxFit.cover,))),
                              title: Text(widget.searchdata[index].title, style: TextStyle(color: Colors.white),),
                              subtitle:Text(widget.searchdata[index].year, style: TextStyle(color: Colors.white),) ,
                            ),
                          ),
                        );
                      },
                    )
            ),
          ],
        ),
      ),
    );
  }
}

