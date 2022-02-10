
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/product_page.dart';
import 'package:ecommerce/services/firebase_services.dart';
import 'package:ecommerce/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({ Key? key }) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

FirebaseServices _firebaseServices = FirebaseServices();
     
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Stack(
       // ignore: prefer_const_literals_to_create_immutables
       children: [

          FutureBuilder<QuerySnapshot>(
                       future: _firebaseServices.usersRef.doc(_firebaseServices.getUserId()).collection("cart").get(),
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
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ProductPage(productId: document.id,)));
                          },
                          child: FutureBuilder<DocumentSnapshot<Object?>>(

                            future: _firebaseServices.productsRef.doc(document.id).get(),
                          
                            builder: (context, productSnap){

                              if(productSnap.hasError) {
                              // ignore: avoid_unnecessary_containers
                              return Container(
                                child: Center(
                                  child: Text("${productSnap.error}"),
                                ),
                              );
                            }
    
                            if(productSnap.connectionState == ConnectionState.done) {
                             Map<String, dynamic> _productMap = productSnap.data!.data() as Map<String, dynamic>;

                            return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal: 24.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    // ignore: sized_box_for_whitespace
                                    Container(
                                      width: 90,
                                      height: 90,
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        child: Image.network(
                                          "${_productMap['images'][0]}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                        left: 16.0,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${_productMap['name']}",
                                            style: const TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.black,
                                                fontWeight:
                                                FontWeight.w600),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets
                                                .symmetric(
                                              vertical: 4.0,
                                            ),
                                            child: Text(
                                              "\$${_productMap['price']}",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Theme.of(context)
                                                      // ignore: deprecated_member_use
                                                      .accentColor,
                                                  fontWeight:
                                                  FontWeight.w600),
                                            ),
                                          ),
                                          Text(
                                            "Size - ${document['size']}",
                                            style: const TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black,
                                                fontWeight:
                                                FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
    
                            }
    
                            // ignore: avoid_unnecessary_containers
                            return Container(
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        ),
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
           hasBackArrow: true,
           title: "Cart",
           hasBackground: false,
           hasTitle: true,
         )
       ],
     ),
      
    );
  }
}