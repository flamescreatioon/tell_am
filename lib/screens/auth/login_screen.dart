import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tell_am/screens/customer/home_screen.dart';
import 'package:tell_am/screens/auth/register_screen.dart';
import 'package:tell_am/components/button_01.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tell_am/utils/dimensions.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SvgPicture.asset(
                    'assets/Logo/Logo_lightmode.svg',
                    semanticsLabel: 'TellAm Logo',
                    height: Dimensions.height45,
                    fit: BoxFit.cover,
                  ),
                  // const Image(
                  //     image: AssetImage('assets/Logo/TellAm (Light)16x9.png')),
                  SizedBox(height: Dimensions.height5),
                  // const Center(
                  //   child: Icon(
                  //     Icons.lock,
                  //     size: 60,
                  //     color: Color.fromARGB(255, 255, 145, 77),
                  //   ),
                  // ),
                  SizedBox(height: Dimensions.height25),
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: Dimensions.font26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Dimensions.height10),
                  Text(
                    'Please login to your account',
                    style: TextStyle(
                        fontSize: Dimensions.font14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Dimensions.height25),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email or Phone Number',
                            hintText: 'Enter your email or phone number',
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius10),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 16.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            prefixIcon: const Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 16.0,
                            ),
                          ),
                        ),
                        SizedBox(height: Dimensions.height15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Checkbox(
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value ?? false;
                                });
                                // Handle checkbox state change
                              },
                              activeColor: const Color.fromARGB(
                                255,
                                255,
                                145,
                                77,
                              ),
                            ),
                            const Text('Remember me'),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot Password?',
                                style: GoogleFonts.leagueSpartan(
                                  color: Color.fromARGB(255, 255, 145, 77),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.height15),
                        ElevatedButton(
                          onPressed: () => (Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          )),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 255, 145, 77),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: Text(
                            'Login',
                            style: GoogleFonts.quicksand(
                              fontSize: Dimensions.font16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.quicksand(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
