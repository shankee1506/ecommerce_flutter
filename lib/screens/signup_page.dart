



import 'package:ecommerce/constants.dart';

import 'package:ecommerce/widgets/custom_input.dart';
import 'package:ecommerce/widgets/custombtn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({ Key? key }) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  // build an alert dialog to display some errors
  Future<void> _alertDialogBuilder(String error) async{
    return showDialog(
      context: context,
      barrierDismissible: false,
       builder: (context){
        return AlertDialog(
          title: const Text("Error"),
          // ignore: avoid_unnecessary_containers
          content: Container(
            child:  Text(error),
          ),

          actions: [
            // ignore: deprecated_member_use
            FlatButton(onPressed: (){
              Navigator.pop(context);
            }, child: const Text("Close dialog"),
            ),
          ],
        );
      }); 
  }
 
  Future<String?> _createAccount() async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: _registerEmail,
    password: _registerPassword
  );
return null;
    }
    on FirebaseAuthException catch(e) {
      if (e.code == 'weak-password') {
    return 'The password provided is too weak.';
  } else if (e.code == 'email-already-in-use') {
    return 'The account already exists for that email.';
  }
  return e.message;
    }
    catch (e) { 
  return e.toString();
  }
  }
 

 void _submitForm() async{
   // set the form to loading state
   setState(() {
     _registerFormLoading = true;
   });

  // run the create account method
   String?  _createAccountFeedback =await  _createAccount();

   // set the string is not null , we got error while create account
   // ignore: unnecessary_null_comparison
   if(_createAccountFeedback != null){
     _alertDialogBuilder(_createAccountFeedback);

  // set the form to regular state [not loading]
     setState(() {
     _registerFormLoading = false;
   });
   }
   
   else {
     // the string was null user logged in
     Navigator.pop(context);
   }
  
 }

 bool _registerFormLoading = false;

  // form input field values
late String _registerEmail = "";
// ignore: prefer_final_fields
late String _registerPassword= "";

  // focus node for input field
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
        super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SingleChildScrollView(
            
            child: SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white
                ),
                width: double.infinity,
                child: Column(
                  
                  
                  children:  [
                    Container(
                      padding: const EdgeInsets.only(top: 20.0) ,
                      child: const Text("Create A New Account ",
                      textAlign: TextAlign.center,
                      style:Constants.boldHeading ,),
                    ),

                    const SizedBox(height: 90.0,),
                    Column( 
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                           CustomInput(
                          text: "Email..",
                          onChanged: (value){
                            _registerEmail = value;
                          },
                          onSubmitted: (value){
                            _passwordFocusNode.requestFocus();
                          },
                          focusNode: FocusNode(),
                          textInputAction: TextInputAction.next,
                          isPasswordField: false,
                        ),
                         CustomInput(
                          text:"Password" ,
                          onChanged: (value) {
                            _registerPassword = value;
                          },

                          focusNode: _passwordFocusNode ,
                          onSubmitted:(value){
                            _submitForm();
                          }, 
                          textInputAction: TextInputAction.done,
                          isPasswordField: true,
                          ),
                        
                        CustomBtn(onPressed: ()
                        {
                           _submitForm();
                        }, 
                        isLoading: _registerFormLoading,
                        outlineBtn: true, 
                        text: "Create  New Account"
                        ),
                      ],
                    ),



                    const SizedBox(height: 170.0,),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 5.0,
                      ),
                      child: CustomBtn(
                        text: "Back to Login",
                        outlineBtn: true,
                        onPressed:() {
                        
                          Navigator.pop(context);
                        },
                        isLoading: false,


                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
