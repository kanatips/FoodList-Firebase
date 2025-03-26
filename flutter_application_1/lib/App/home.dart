import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/add_user.dart';



class Home extends StatelessWidget {
  Home({super.key});

  // collection users
  final users = FirebaseFirestore.instance.collection('thaifood');

  // อ่านข้อมูล
  Stream<QuerySnapshot> getUsers() {
    return users.snapshots();
  }

  // ลบข้อมูล
  Future<void> deleteUser(String docId) {
    return users.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Food List")),
      body: StreamBuilder<QuerySnapshot>(
        stream: getUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              return ListTile(
                leading: CircleAvatar(child: Text("${data['menu_name']}")),
                title: Text(data['ingredients']),
                subtitle: Text("${data['image_url']}"),
                trailing: IconButton(onPressed: () => deleteUser(docs[index].id), icon: Icon(Icons.delete)),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            
            MaterialPageRoute(builder: (_) => AddUserScreen(users: users)),
            
          );
        },
      ),
    );
  }
}
