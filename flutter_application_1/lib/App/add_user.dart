import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class AddUserScreen extends StatefulWidget {
  final CollectionReference<Map<String, dynamic>> users;
  const AddUserScreen({super.key, required this.users});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final nameController = TextEditingController();
  final menuController = TextEditingController();
  final imgController = TextEditingController();
  final ingredientsController = TextEditingController();

  Future<void> addUser() async {
    final String name = nameController.text;
    final String imgurl = imgController.text;
    final String menuName = menuController.text;
    final String ingredients = ingredientsController.text;

    if (name.isNotEmpty && menuName.isNotEmpty && imgurl.isNotEmpty&&ingredients.isNotEmpty) {
      nameController.clear();
      menuController.clear(); 
      imgController.clear();
      ingredientsController.clear();

    
      // เพิ่มข้อมูล
      await widget.users.add({'name': name, 'menu_name': menuName, 'image_url': imgurl,'ingredients':ingredients});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เพิ่มผู้ใช้')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'ชื่อ'),
            ),
            TextField(
              
              controller: menuController,
              decoration: InputDecoration(labelText: 'เมนู'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              
              controller: imgController,
              decoration: InputDecoration(labelText: 'รูปภาพ'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            TextField(
              controller: ingredientsController,
              decoration: InputDecoration(labelText: 'ส่วนผสม'),
              keyboardType: TextInputType.emailAddress,
            ),
            ElevatedButton(
              onPressed: addUser,
              child: Text('เพิ่มเมนู'),
            ),
          ],
        ),
      ),
    );
  }
}
