

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/services/firebase_services.dart';
import 'package:ecommerce/widgets/image_swipe.dart';
import 'package:ecommerce/widgets/product_size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/widgets/custom_action_bar.dart';

class ProductPage extends StatefulWidget {
final String productId;

  const ProductPage({ Key? key, required this.productId }) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

FirebaseServices _firebaseServices = FirebaseServices();

  Future _addtoCart(){
        return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId()).collection("cart")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
      }
   


     String _selectedProductSize = "0";

final SnackBar _snackBar =const SnackBar(content: Text("Product Added to the cart"),);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( 
        children: [
         FutureBuilder<DocumentSnapshot<Object?>>(
           future: _firebaseServices.productsRef.doc(widget.productId).get(),
           builder: (context, snapshot){
              if(snapshot.hasError){
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}" 
                    ),
                  ),
                );
           }
           
          
           if (snapshot.connectionState == ConnectionState.done){
                 // Firebase Document Data Map
                // ignore: unused_local_variable
             Map<String, dynamic> documentData = snapshot.data!.data() as Map<String, dynamic>;


            // list of images
            List imageList = documentData['images'];
            List productSizes = documentData['size'];
            
            // set an initial size
            _selectedProductSize = productSizes[0];

              return ListView(
                padding: const EdgeInsets.all(0),
                children: [
                  
                    ImageSwipe(imageList: imageList),
                   Padding(
                    padding: const EdgeInsets.only(
                      top: 24.0,
                      left: 24.0,
                      right: 24.0,
                      bottom: 4.0,
                    ),
                    child: Text("${documentData['name']}",
                    style: Constants.boldHeading,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 12.0,
                    ),
                    child: Text("Rs ${documentData['price']}",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      // ignore: deprecated_member_use
                      color: Theme.of(context).accentColor,
                    ),),
                  ),
                 Padding(
                   padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 12.0,
                    ),
                   child: Text("${documentData['desc']}",
                    style: const TextStyle(
                      fontSize: 16.0,
                      
                      
                    ),),
                 ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 12.0,
                    ),
                    child: Text("Select Size",
                    style: Constants.regularDarkText,),
                  ),
                
                ProductSize(productSizes: productSizes,
                onSelected:(size){
                  _selectedProductSize= size;
                }
                ),

                 Padding(
                   padding: const EdgeInsets.all(15.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Container(
                         width: 50.0,
                         height: 50.0,
                         decoration: BoxDecoration(
                           color: const Color(0xFFDCDCDC),
                           borderRadius: BorderRadius.circular(12.0),
                         ),
                         alignment: Alignment.center,
                         child: const Image(
                           image: AssetImage("assets/images/tab_saved.png"),
                           width: 20.0,
                           height: 22.0,
                           ),
                       ),
                       Expanded(
                         child: GestureDetector(
                           onTap: () async{
                             await _addtoCart();
                             // ignore: deprecated_member_use
                             Scaffold.of(context).showSnackBar(_snackBar);
                           },
                           
                           child: Container(
                             margin: const EdgeInsets.only(
                               left: 60.0,
                               right: 40.0,
                             ),
                             height: 50.0,
                             decoration: BoxDecoration(
                               color: Colors.black,
                               borderRadius: BorderRadius.circular(12.0),
                             ),
                             alignment: Alignment.center,
                             child: const Text("Add to card",
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: 16.0,
                               fontWeight: FontWeight.w600,
                             ),),
                           ),
                         ),
                       )
                     ],
                   ),
                 ),  
                ],
              );

           }


            return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                    ),
                  );
           
           }
           
           
           ),
        

         const CustomActionBar(
          title: "", 
          hasBackArrow: true, 
          hasTitle: false,
          hasBackground: true,
          ),
        ],
      ),
    );
  }
}