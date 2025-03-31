import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/App/menudetail.dart';
import 'package:flutter_application_1/app/add_user.dart';



class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller=TextEditingController();

  // collection users
  final food = FirebaseFirestore.instance.collection('thaifoods');

  // อ่านข้อมูล
  Stream<QuerySnapshot> getUsers() {
    if(controller.text.isEmpty){
      return food.snapshots();
    }
    else{
        return food
        .where("menu_name", isGreaterThanOrEqualTo: controller.text)
        .where("menu_name",isLessThanOrEqualTo: controller.text+'\uf8ff')
        .snapshots();
        
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,     
      body: Column(
        children: [
          SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.only(left: 15,right:15),
            child: TextField(
              controller: controller,
             onSubmitted: (value) {
              controller.text = value;
               setState(() {
               });
             },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey),
                    borderRadius: BorderRadius.circular(8))),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: getUsers(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                final docs = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;
                    return InkWell(
                      onTap: () {
                        Navigator.push<void>(
                          context, 
                       MaterialPageRoute<void>(builder: (_)=>Detail(
                        img: data["image_url"],
                        ingredients: data['ingredients'],
                        menu: data['menu_name'],
                        name: data['name'],
                       ))
                       );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade50,
                                
                                borderRadius: BorderRadius.circular(10)
                                ),
                              height: 200,
                              child: Row( 
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          
                                        children: [
                                          Text("${data['name']}"),
                                          Text("${data['menu_name']}",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                                          Text("${data['ingredients']}",maxLines: 3)
                                        ],
                                      ),
                                    )
                                  ),
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(topRight:Radius.circular(10),bottomRight: Radius.circular(10)),
                                      child: Image.network("${data["image_url"]}",
                                      height: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 30,)
                          ],
                        ),
                      ),
                    );
                    
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddUserScreen(users: food)),
          );
        },
      ),
    );
  }
}
