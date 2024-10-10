import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {
  Future addProductData(Map<String, dynamic> productdata, String id) async{
    return await FirebaseFirestore.instance.collection('Product').doc(id).set(productdata);
  }

  Future<Stream<QuerySnapshot>> getProductData() async{
    return await FirebaseFirestore.instance.collection('Product').snapshots();
  }

  Future updateProductData(String id, Map<String, dynamic> updatedProductData) async{
    return await FirebaseFirestore.instance.collection('Product').doc(id).update(updatedProductData);
  }

  Future deleteProductData(String id) async{
    return await FirebaseFirestore.instance.collection('Product').doc(id).delete();
  }

}