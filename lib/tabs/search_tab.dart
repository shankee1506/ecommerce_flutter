

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/services/firebase_services.dart';
import 'package:ecommerce/widgets/custom_input.dart';
import 'package:ecommerce/widgets/product_cart.dart';
import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {


   SearchTab({ Key? key }) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _searchString ="";

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
                 child: Stack(
                   children: [
                     if(_searchString.isEmpty)
                     Center(
                       child: Container(
                         
                         // ignore: prefer_const_constructors
                         child:  Text("Search Results",
                         style: Constants.regularDarkText,
                         
                         ),
                       ),
                     )
                     else
                     FutureBuilder<QuerySnapshot>(
                       future: 
                       _firebaseServices.productsRef.orderBy("searchstring")
                       .startAt([_searchString])
                       .endAt(["$_searchString\uf8ff"])
                       .get(),
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
                        top: 100.0,
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

                     Padding(
                       padding: const EdgeInsets.only(
                         top: 40.0,
                       ),
                       child: CustomInput(
                         text:"Search here...", 
                         onChanged: (value){

                         }, 
                         onSubmitted: (value){
                           
                             setState(() {
                               _searchString = value.toLowerCase();
                             });
                           
                         }, 
                         focusNode: FocusNode(), 
                         textInputAction: TextInputAction.done, 
                         isPasswordField: false),
                     ),

                      
                        

                       
                   ],
                 )
               );
  }
}