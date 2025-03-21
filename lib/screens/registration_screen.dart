import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:pokepedia/screens/home_screen.dart';
import 'package:pokepedia/screens/login_screen.dart';
import 'package:pokepedia/widgets/button.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController usercontroller = TextEditingController();
TextEditingController emailcontroller = TextEditingController();
TextEditingController pwdcontroller = TextEditingController();
bool obsecureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 300,
                  width: 300,
                  child: Lottie.asset('assets/animations/lottie2.json')),
              ),
              

              Text('Sign Up',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.cyan
              ),),
              SizedBox(height: 10,),
              Text('Use Proper Information To Continue',
              style: TextStyle(
                fontSize: 15,
                color: Colors.blueGrey
              ),),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: usercontroller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person,color: Colors.blueGrey),
                    hintText: 'User Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.cyan)
                    ),
                    suffixIcon: emailcontroller.text.isEmpty 
                    ? Container(
                      width: 0,
                    )
                    : IconButton(
                      onPressed: (){
                        emailcontroller.clear();
                      },
                      icon:Icon(Icons.close),),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email,color: Colors.blueGrey),
                    hintText: 'Email ID',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.cyan)
                    ),
                    suffixIcon: emailcontroller.text.isEmpty 
                    ? Container(
                      width: 0,
                    )
                    : IconButton(
                      onPressed: (){
                        emailcontroller.clear();
                      },
                      icon:Icon(Icons.close),),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: [AutofillHints.email],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  obscureText: obsecureText,
                  controller: pwdcontroller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock,color: Colors.blueGrey),
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.cyan)
                    ),
                    suffixIcon: pwdcontroller.text.isEmpty 
                    ? Container(
                      width: 0,
                    )
                    : GestureDetector(
                      onTap: (){
                        setState(() {
                          obsecureText = false;
                        });
                      },
                      onDoubleTap: () {
                        setState(() {
                          obsecureText = true ;
                        });
                      },
                      child: Icon(Icons.remove_red_eye,color: Colors.blueGrey,),
                    )
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  autofillHints: [AutofillHints.password],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: LoadingAnimatedButton(
                  child: Text('Sign Up',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)), 
                  onTap: (){
                    print("object");
                    registerUser();
                    final form = formKey.currentState;
                    String user = usercontroller.text;
                  String email = emailcontroller.text;
                  String password = pwdcontroller.text;
                  print("$email");
                  print("$password");
                  print("$user");
                  if( form!.validate()){
                    final email = emailcontroller.text;
                    final password = pwdcontroller.text;
                  }else {}

                }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey
                  ),),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> LoginScreen()));
                    },
                    child: Text("Sign In",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue
                    ),),
                  ),
                ],
              ),
             
              ]
            
          ),
        ),
      ),
    );
  }
  void registerUser(){
    if(usercontroller.text == ""){
      Fluttertoast.showToast(msg: "User Name Can Not Be Blank", backgroundColor: Colors.red);
    }else if(emailcontroller.text == ""){
      Fluttertoast.showToast(msg: "Email Can Not Be Blank", backgroundColor: Colors.red);
    }
    else if(pwdcontroller.text == ""){
      Fluttertoast.showToast(msg: "Password Can Not Be Blank", backgroundColor: Colors.red);
    }
    else{
      // String user = usercontroller.text;
      String email = emailcontroller.text;
      String password = pwdcontroller.text;
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value){
        if(value != null){
          var user =value.user;
          var uid = user!.uid;
          addUserData(uid);
        }
        
      }
      ).catchError((e){
         Fluttertoast.showToast(msg: "$e", backgroundColor: Colors.red);
      });
    }

  }
  void addUserData(String uid){
    Map<String,dynamic> usersData ={
      'user' : usercontroller.text,
      'email' : emailcontroller.text,
      'password' : pwdcontroller.text,
      'uid' : uid,

    };
    FirebaseFirestore.instance.collection('users').doc(uid).set(usersData).then((value){
      Fluttertoast.showToast(msg: "Registration Successful", backgroundColor: Colors.green);
       Navigator.push(context, MaterialPageRoute(builder: (_)=> LoginScreen()));
    }).catchError((e){
         Fluttertoast.showToast(msg: "$e", backgroundColor: Colors.red);
      });
  }
}