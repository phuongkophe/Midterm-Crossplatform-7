import 'package:firebase_crud_app/firebase_database/database_method.dart';
import 'package:firebase_crud_app/utils/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class AddNewData extends StatefulWidget {
  const AddNewData({super.key});

  @override
  State<AddNewData> createState() => _AddNewDataState();
}

class _AddNewDataState extends State<AddNewData> {
  TextEditingController nameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Add new product',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Product Name',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                border: Border.all(width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              'Price',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                border: Border.all(width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: priceController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              'Type',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                border: Border.all(width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: typeController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700
                ),
                onPressed: () async {
                  String id = randomAlphaNumeric(8);
                  Map<String, dynamic> productData = {
                    'Product Name': nameController.text,
                    'Price': priceController.text,
                    'Type': typeController.text,
                    'Id': id,
                  };
                  await DatabaseMethod().addProductData(productData, id).then((value){
                    ShowToasts().getToast('Data Saved Successfully', Colors.green);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
                  child: Text(
                    'Add New Product',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
