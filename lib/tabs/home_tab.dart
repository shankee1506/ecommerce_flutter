
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/product_page.dart';
import 'package:ecommerce/widgets/custom_action_bar.dart';
import 'package:ecommerce/widgets/product_cart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {

  final CollectionReference _productsRef = 
     FirebaseFirestore.instance.collection("products");
   HomeTab({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return  Container(
                 child: Stack(
                   children:  [
                     FutureBuilder<QuerySnapshot>(
                       future: _productsRef.get(),
                       builder: (context, snapshot){
                           if(snapshot.hasError){
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"
                    ),
                  ),
                );
                       }

                // collection data ready to display
                if(snapshot.connectionState == ConnectionState.done){
                    // display the data inside a list view
                    return ListView(
                      padding: const EdgeInsets.only(
                        top: 80.0,
                        bottom: 24.0,
                      ),
                      children: snapshot.data!.docs.map((document) {


                        // ignore: avoid_unnecessary_containers
                        return ProductCart(
                          
                        onPressed: (){

                        }, 
                        imageUrl: document['images'][0], 
                        title: document['name'], 
                        price: "Rs ${document['price']}", 
                        productId: document.id,
                        );
                      }
                      ).toList(),
                    );
                }



                      //loading state
                       return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                    ),
                  );
                
                       }

                       ),
                     
                     
                     const CustomActionBar(
                       title: "Home",
                       hasBackArrow: false,
                       hasTitle: true,
                       hasBackground: true
                     ),
                   ],
                 ),

                
    );
  }
}