import 'package:flix/models/data_model.dart';
import 'package:flutter/material.dart';

class TitleInfoPage extends StatefulWidget {
  final Movie data;
  const TitleInfoPage({super.key, required this.data});

  @override
  State<TitleInfoPage> createState() => _TitleInfoPageState();
}

class _TitleInfoPageState extends State<TitleInfoPage> {
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
        extendBodyBehindAppBar: true,
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0,),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey,
                        image: DecorationImage(image: NetworkImage(widget.data.poster), fit : BoxFit.cover),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade800,
                            offset: Offset(
                              6,
                              6,
                            ),
                            blurRadius: 20,
                            spreadRadius: 10
                            //blurStyle: BlurStyle.outer
                            ),
                        BoxShadow(
                            color: Colors.grey.shade800,
                            offset: Offset(
                              -6,
                              -6,
                            ),
                            blurRadius: 20,
                            spreadRadius: 10),
                      ]),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        
                        color: Colors.green,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade800,
                              offset: Offset(
                                6,
                                6,
                              ),
                              blurRadius: 20,
                              spreadRadius: 10
                              //blurStyle: BlurStyle.outer
                              ),
                          BoxShadow(
                              color: Colors.grey.shade800,
                              offset: Offset(
                                -6,
                                -6,
                              ),
                              blurRadius: 20,
                              spreadRadius: 10),
                        ]),
                    height: 60,
                    width: 60,
                    //width: MediaQuery.of(context).size.width * 0.4,
                     child: Icon(Icons.play_arrow_rounded, size: 40,)
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.yellow.shade800,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade800,
                              offset: Offset(
                                6,
                                6,
                              ),
                              blurRadius: 20,
                              spreadRadius: 10
                              //blurStyle: BlurStyle.outer
                              ),
                          BoxShadow(
                              color: Colors.grey.shade800,
                              offset: Offset(
                                -6,
                                -6,
                              ),
                              blurRadius: 20,
                              spreadRadius: 10),
                        ]),
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text("DOWNLOAD ", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22, color: Colors.white),)
                  ),
                ],
              ),
               SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(widget.data.title, textAlign: TextAlign.center,style: TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.w700),)),
               SizedBox(
                height: 40,
              ),

              Container(
                  padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade400,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade800,
                              offset: Offset(
                                6,
                                6,
                              ),
                              blurRadius: 20,
                              spreadRadius: 10
                              //blurStyle: BlurStyle.outer
                              ),
                          BoxShadow(
                              color: Colors.grey.shade800,
                              offset: Offset(
                                -6,
                                -6,
                              ),
                              blurRadius: 20,
                              spreadRadius: 10),
                        ]),
                    
                    width: MediaQuery.of(context).size.width ,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("PLOT", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, ),),
                        Divider(thickness: 2,),
                        Text(widget.data.plot, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic),)
                      ],
                    )
                  ),
                  SizedBox(height: 100,)
            ],
          ),
        ),
      ),
    );
  }
}
