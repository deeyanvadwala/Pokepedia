
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:pokepedia/screens/home_screen.dart';
import 'package:pokepedia/screens/registration_screen.dart';
import 'package:pokepedia/widgets/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
TextEditingController emailcontroller = TextEditingController();
TextEditingController pwdcontroller = TextEditingController();
bool obsecureText = true;
void initState(){
  emailcontroller.addListener( (){listener: (context);});
  pwdcontroller.addListener( (){listener: (context);});
  super.initState();
}
void dispose(){
  emailcontroller.removeListener((){listener:(context);});
  pwdcontroller.removeListener((){listener:(context);});
  super.dispose();
}
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
                  child: Lottie.asset('assets/animations/lottie1.json')),
              ),
              SizedBox(height: 10,),

              Text('Log In',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.cyan
              ),),
              
              Text('Enter Valid Email ID And Password',
              style: TextStyle(
                fontSize: 15,
                color: Colors.blueGrey
              ),),

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
                child: LoadingAnimatedButton(child: Text('Login',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)), onTap: (){
                  LoginUser();
                  final form = formKey.currentState;
                  String email = emailcontroller.text;
                  String password = pwdcontroller.text;
                  print("$email");
                  print("$password");
                  if( form!.validate()){
                    final email = emailcontroller.text;
                    final password = pwdcontroller.text;
                  }else {}
                }),

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an Account?",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey
                  ),),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> RegistrationScreen()));
                    },
                    child: Text("Sign Up",
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
  void LoginUser(){
    if(pwdcontroller.text == ""){
      Fluttertoast.showToast(msg: "Password Can Not Be Blank", backgroundColor: Colors.red);
    }
    else if(emailcontroller.text == ""){
      Fluttertoast.showToast(msg: "Email Can Not Be Blank", backgroundColor: Colors.red);
      }
    else{
      String email = emailcontroller.text;
      String password = pwdcontroller.text;
      FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
      }
      ).catchError((e){
         Fluttertoast.showToast(msg: "$e", backgroundColor: Colors.red);
      });
    }

  }
}