

import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/home_page.dart';
import 'package:ecommerce/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {

  final Future<FirebaseApp>  _initializations =  Firebase.initializeApp();

   LandingPage({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializations,
      builder: (context, snapshot){
        if(snapshot.hasError){
          return Scaffold(
            body: Center(
              child: Text("error: ${snapshot.error}"),
            ),
          );
        }

        if(snapshot.connectionState == ConnectionState.done){
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnapshot){

              if(streamSnapshot.hasError){
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${streamSnapshot.error}"
                    ),
                  ),
                );

                  }

              // connection state actin - do the user login check inside the if statement
               if(streamSnapshot.connectionState == ConnectionState.active){

                  // get the user 
                  Object? _user = streamSnapshot.data;
                  
                  // ignore: unnecessary_null_comparison
                  if (_user == null){
                    return const LoginPage();
                  }
                  else {
                    return const HomePage();
                  }
                  
          }
           
              
              // checking for auth state -loading
              return const Scaffold(
          body: Center(
            child: Text("Checking Authendication",
            style: Constants.regularHeading,),
          ),
        );
            } 
          );
        }

        return const Scaffold(
          body: Center(
            child: Text("Intialization app...",
            style: Constants.regularHeading,),
          ),
        );
      },
      
      );
  }
}