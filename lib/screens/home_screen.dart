import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud_app/firebase_database/database_method.dart';
import 'package:firebase_crud_app/screens/add_new_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/show_toast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream? userStream;

  TextEditingController nameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  getInitialUser() async {
    userStream = await DatabaseMethod().getProductData();
    setState(() {});
  }

  @override
  void initState() {
    getInitialUser();
    super.initState();
  }

  Widget allProductDataList() {
    return StreamBuilder(
        stream: userStream,
        builder: (context, AsyncSnapshot snapShot) {
          return snapShot.hasData
              ? ListView.builder(
                  itemCount: snapShot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot productData = snapShot.data.docs[index];
                    return SizedBox(
                      height: 180.0,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: Colors.blue.shade50,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.blue.shade700, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Product Name : ' + productData['Product Name'],
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Price : ' + productData['Price'],
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Type : ' + productData['Type'],
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.blue.shade100),
                                        onPressed: () {
                                          nameController.text =
                                              productData['Product Name'];
                                          priceController.text =
                                              productData['Price'];
                                          typeController.text =
                                              productData['Type'];
                                          editProductDetail(productData['Id']);
                                        },
                                        child: Text(
                                          'Edit',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.blue.shade700,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: () {
                                          deleteProductData(productData['Id']);
                                        },
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        )),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Products list',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddNewData();
          }));
        },
      ),
      body: allProductDataList(),
    );
  }

  Future editProductDetail(String id) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 420,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Edit Product Detail',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.cancel,
                          color: Colors.blue.shade700,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
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
                          backgroundColor: Colors.blue.shade700),
                      onPressed: () async {
                        Map<String, dynamic> updatedProductData = {
                          'Product Name': nameController.text,
                          'Price': priceController.text,
                          'Type': typeController.text,
                          'Id': id,
                        };
                        await DatabaseMethod()
                            .updateProductData(id, updatedProductData)
                            .then((value) {
                          Navigator.pop(context);
                          ShowToasts().getToast(
                              'Data Updated Successfully', Colors.green);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 15.0),
                        child: Text(
                          'Update Product',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future deleteProductData(String id) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 120.0,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Are you sure want to delete this product?',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.cancel,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0,),
                  Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700),
                        onPressed: () async {
                          await DatabaseMethod()
                              .deleteProductData(id)
                              .then((value) {
                            Navigator.pop(context);
                            ShowToasts().getToast(
                                'Data Deleted Successfully', Colors.red);
                          });
                        },
                        child: const Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 15.0),
                          child: Text(
                            'Delete Product Data',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          );
        });
  }
}
