


import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/signup_page.dart';
import 'package:ecommerce/widgets/custom_input.dart';
import 'package:ecommerce/widgets/custombtn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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


  Future<String?> _loginAccount() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: _loginEmail,
    password: _loginPassword
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

   bool _loginFormLoading = false;

  // form input field values
late String _loginEmail = "";
// ignore: prefer_final_fields
late String _loginPassword= "";


  void _submitForm() async{
   // set the form to loading state
   setState(() {
     _loginFormLoading = true;
   });

  // run the create account method
   String?  _loginFeedback =await  _loginAccount();

   // set the string is not null , we got error while create account
   // ignore: unnecessary_null_comparison
   if(_loginFeedback != null){
     _alertDialogBuilder(_loginFeedback);

  // set the form to regular state [not loading]
     setState(() {
     _loginFormLoading = false;
   });
   }
   
   
  
 }

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
                      child: const Text("Welcome User \nLogin Your Account ",
                      textAlign: TextAlign.center,
                      style:Constants.boldHeading ,),
                    ),

                    const SizedBox(height: 90.0,),
                    Column( 
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         CustomInput(
                          text: "Email..",
                          onChanged:(value) {
                            _loginEmail = value;
                          } ,
                          onSubmitted:(value){
                            _passwordFocusNode.requestFocus();
                          }, 
                          focusNode:FocusNode() ,
                          textInputAction: TextInputAction.next,
                          isPasswordField: false,
                         ),
                         CustomInput(
                          text:"Password" ,
                          onChanged:(value) {
                            _loginPassword = value;
                          } ,
                          onSubmitted:(value){
                            _submitForm();
                          } ,
                          focusNode: FocusNode(),
                          textInputAction: TextInputAction.done,
                          isPasswordField: true,
                          ),
                        CustomBtn(
                          onPressed: ()
                        {
                            _submitForm();
                        }, 
                        outlineBtn: false, 
                        text: "Login",
                        isLoading: _loginFormLoading,
                        ),
                      ],
                    ),



                    const SizedBox(height: 170.0,),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 5.0,
                      ),
                      child: CustomBtn(
                        text: "Create New Account",
                        outlineBtn: true,
                        onPressed:() {
                        
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupPage()));
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