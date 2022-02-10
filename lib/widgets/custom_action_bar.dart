
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/cart_page.dart';
import 'package:ecommerce/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomActionBar extends StatelessWidget {

  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  final bool hasBackground;


  

  const CustomActionBar({ Key? key, required this.title, required this.hasBackArrow, required this.hasTitle, required this.hasBackground }) : super(key: key);



  @override
  Widget build(BuildContext context) {

    bool _hasBackArrow = hasBackArrow;
    bool _hasTitle = hasTitle;
    bool _hasBackground = hasBackground;

    FirebaseServices _firebaseServices = FirebaseServices();


final CollectionReference _usersRef = 
     FirebaseFirestore.instance.collection("Users");





    return Container(
      decoration:   BoxDecoration(
        gradient:_hasBackground ? LinearGradient(
          colors: [
            Colors.indigoAccent,
            Colors.indigo.withOpacity(0),
          ],
          begin: const Alignment(0, 0),
          end: const Alignment(0, 1)
        ):null
      ),

      padding: const EdgeInsets.only(
        top: 46.0,
        left: 24.0 ,
        right: 24.0,
        bottom: 42.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
  
        children: [
          if(_hasBackArrow)
          GestureDetector(
            onTap:(){
              Navigator.pop(context);
            },
            child: Container(
              width: 38.0,
              height: 38.0,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
                child: const Image(
                  image: AssetImage("assets/images/back_arrow.png"),
                  color: Colors.white,
                  width: 18.0,
                  height: 18.0,
                  ),
                  
                
            ),
          ),

          if(_hasTitle)
            Text(title,
          style: Constants.boldHeading,
          ),

          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const CartPage(),));
            },
            child: Container(
              width: 38.0,
              height: 38.0,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: StreamBuilder<QuerySnapshot>(
                stream: _usersRef.doc(_firebaseServices.getUserId()).collection("cart").snapshots(),
          
                builder:(context, snapshot){
                  int _totalItems = 0;
          
                  if(snapshot.connectionState == ConnectionState.active){
                    
                    List _documents = snapshot.data!.docs;
                     _totalItems = _documents.length;
                  }
          
                return Text("$_totalItems",
                style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Colors.white
          
                
              ),);
                } ,),
                  
            ),
          ),
        ],

      ),
    );
  }
}