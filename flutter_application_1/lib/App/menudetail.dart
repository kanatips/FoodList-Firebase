import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  final String? name;
  final String? menu;
  final String? ingredients;
  final String img;
   const Detail({super.key,required this.name,required this.menu,required this.ingredients,required this.img});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("รายละเอียด"),),
      body: Column(
        children: [
          Image.network(img,
          height: MediaQuery.of(context).size.height*0.4,
          fit: BoxFit.cover
          ),
          Column(
            children: [
              Text("$menu",style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text("โดย $name"),
               SizedBox(height: 5,),
              Text("$ingredients"),
              
            ],
          )

        ],
      ),
    );
  }
}