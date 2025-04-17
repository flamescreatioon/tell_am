import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>{

  @override
  Widget build(BuildContext context){
    return const Scaffold(
      body: SafeArea(
        child: Center (
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                Center(
                  child: Icon(
                    Icons.lock,
                    size: 100,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(height: 24.0),

                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8.0),

                Text(
                  'Please login to your account',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,

                  ),
                )

              ],
            )
          )
        )
      ) 
    );
  }
}